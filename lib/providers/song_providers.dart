import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/repositories/song_repository.dart';
import 'package:foutain_desktop/services/session_manager.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';

import 'general_providers.dart';

final currentSong = Provider<Song>((_) => throw UnimplementedError());
final categoryProvider = Provider<String>((_) => throw UnimplementedError());
final songsRepositoryProvider =
    Provider<SongsRepository>((ref) => SongsRepository(ref.read));

final songsListStateProvider =
    StateNotifierProvider<SongsListNotifier, AsyncValue<List<Song>>>(
        (ref) => SongsListNotifier(ref.read));

class SongsListNotifier extends StateNotifier<AsyncValue<List<Song>>> {
  SongsListNotifier(this._read) : super(const AsyncValue.loading()) {
    getSongs();
  }
  final Reader _read;

  Future<void> getSongs() async {
    try {
      List<Song> songs = await _read(songsRepositoryProvider).getSongs();
      // if (mounted) {
      state = AsyncData(songs);
      // }
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateSong(Song updatesong) async {
    try {
      await _read(songsRepositoryProvider).updateSong(updatesong);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatesong.id) updatesong else item
        ]);
      });
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final songListProvider = Provider<List<Song>>((ref) {
  final songsListState = ref.watch(songsListStateProvider);
  return songsListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final editSongProvider = Provider<List<Song>>((ref) {
  final songsListState = ref.watch(songsListStateProvider);
  return songsListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final songDetailProvider = Provider<List<Song>>((ref) {
  final songsListState = ref.watch(songsListStateProvider);
  return songsListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final favSongsListProvider = Provider<List<Song>>((ref) {
  final songsListState = ref.watch(songsListStateProvider);
  return songsListState.maybeWhen(
      data: (data) => data.where((e) => e.isFavorite == 1).toList(),
      orElse: () => []);
});

final favSongsCatProvider = Provider<List<Song>>((ref) {
  final songsListState = ref.watch(songsListStateProvider);
  return songsListState.maybeWhen(
      data: (data) => data.where((e) => e.isFavorite == 1).toList(),
      orElse: () => []);
});

final mainFavSongsProvider = Provider<List<Song>>((ref) {
  return ref.watch(favSongsListProvider);
});

//SONGS LIST
final searchResultsProvider =
    Provider.family<List<Song>, List<Song>>((ref, songs) {
  final query = ref.watch(searchQueryProvider);
  final songsList = songs.map((e) => e.songId).toSet();
  songs.retainWhere((x) => songsList.remove(x.songId));
  return query == 'query'
      ? songs
      : songs
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              song.sngNumber == int.tryParse(query) ||
              song.verse.toLowerCase().contains(query))
          .toList();
});

final favSongsByCategoryProvider =
    Provider.family<List<Song>, String>((ref, category) {
  final query = ref.watch(searchQueryProvider);
  List<Song> songs = ref
      .watch(favSongsCatProvider)
      .where((song) => song.category == category)
      .toList();
  return query == 'query'
      ? songs
      : songs
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              song.sngNumber == int.tryParse(query) ||
              song.verse.toLowerCase().contains(query))
          .toList();
});

final filteredSongListProvider = Provider<List<Song>>((ref) {
  final songListFilterState = ref.watch(menuSelectorProvider);
  List<Song> songs = ref.watch(songListProvider);
  switch (songListFilterState) {
    case MenuSelector.hymn:
      songs = songs.where((song) => song.category == 'Hymn Book').toList();
      List<Song> searchResults = ref.watch(searchResultsProvider(songs));
      return searchResults.isEmpty ? songs : searchResults;
    case MenuSelector.injili:
      songs =
          songs.where((song) => song.category == 'Nyimbo Za Injili').toList();
      List<Song> searchResults = ref.watch(searchResultsProvider(songs));
      return searchResults.isEmpty ? songs : searchResults;
    case MenuSelector.enyimba:
      songs =
          songs.where((song) => song.category == 'Enyimba Za Kristo').toList();
      List<Song> searchResults = ref.watch(searchResultsProvider(songs));
      return searchResults.isEmpty ? songs : searchResults;
    case MenuSelector.kikuyu:
      songs =
          songs.where((song) => song.category == 'Nyimbo Cia Kiroho').toList();
      List<Song> searchResults = ref.watch(searchResultsProvider(songs));
      return searchResults.isEmpty ? songs : searchResults;
    case MenuSelector.tenzi:
      songs =
          songs.where((song) => song.category == 'Tenzi Za Rohoni').toList();
      List<Song> searchResults = ref.watch(searchResultsProvider(songs));
      return searchResults.isEmpty ? songs : searchResults;
    case MenuSelector.favsongs:
      return songs.where((song) => song.isFavorite == 1).toList();
    default:
      return songs;
  }
});

//SONG DETAIL
final songSetterProvider = StateProvider<Song?>((ref) => null);

final songdetailProvider = Provider<List<Song>>((ref) {
  final song = ref.watch(songSetterProvider);
  final songs = ref.watch(songDetailProvider);
  return songs
      .where((e) => e.songId == song!.songId && e.category == song.category)
      .toList();
});

final verseCountProvider = StateProvider<int>((ref) => 1);

final songVersesProvider = Provider<List<Song>>((ref) {
  final verse = ref.watch(verseCountProvider);
  final songListState = ref.watch(songdetailProvider);
  return songListState.where((e) => e.vrsNumber == verse).toList();
});

final colorProvider = StateNotifierProvider<ColorNotifier, Color>(
    (ref) => ColorNotifier(ref.read));

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier(this._read) : super(Colors.white) {
    state = _read(sessionManagerProvider).getSnBgColor();
  }

  final Reader _read;

  void setColor(Color color) async {
    try {
      await _read(sessionManagerProvider).setSnBgColor(color);
      state = color;
    } catch (e) {
      state = Colors.white;
    }
  }
}

final fontcolorProvider = StateNotifierProvider<FontColorNotifier, Color>(
    (ref) => FontColorNotifier(ref.read));

class FontColorNotifier extends StateNotifier<Color> {
  FontColorNotifier(this._read) : super(Colors.white) {
    state = _read(sessionManagerProvider).getSngFntColor();
  }

  final Reader _read;

  void setColor(Color color) async {
    try {
      await _read(sessionManagerProvider).setSngFntColor(color);
      state = color;
    } catch (e) {
      state = Colors.white;
    }
  }
}
