import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/repositories/song_repository.dart';
import 'package:foutain_desktop/services/database.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'general_providers.dart';

final songDetailProvider =
    StateNotifierProvider<SongDetailNotifier, List<Song>?>((ref) {
  return SongDetailNotifier(ref.read);
});

class SongDetailNotifier extends StateNotifier<List<Song>> {
  SongDetailNotifier(this._read) : super([]);
  final Reader _read;

  Future<void> setSongDetail(Song s) async {
    try {
      state = await _read(databaseProvider).getSongsById(s.songId, s.category);
    } on Exception {
      state = [];
    }
  }
}

final searchResultsProvider =
    Provider.family<List<Song>, List<Song>>((ref, songs) {
  final query = ref.watch(searchQueryProvider);
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
  return ref.watch(songsListStateProvider).maybeWhen(
      data: (songs) {
        final searchList = ref.watch(searchResultsProvider(songs));
        return searchList.isNotEmpty
            ? searchList
            : songs
                .where(
                    (song) => song.category == category && song.isFavorite == 1)
                .toList();
      },
      orElse: () => []);
});

final songsRepositoryProvider =
    Provider<SongsRepository>((ref) => SongsRepository(ref.read));

final songsListStateProvider =
    StateNotifierProvider<SongsListNotifier, AsyncValue<List<Song>>>(
        (ref) => SongsListNotifier(ref.read));

final filteredSongListProvider = Provider<List<Song>>((ref) {
  final songListFilterState = ref.watch(menuSelectorProvider);
  final songListState = ref.watch(songsListStateProvider);
  final query = ref.watch(searchQueryProvider);
  return songListState.maybeWhen(
    data: (songs) {
      switch (songListFilterState) {
        case MenuSelector.hymn:
          songs = songs.where((song) => song.category == 'Hymn Book').toList();
          songs = query == 'query'
              ? songs
              : songs
                  .where((song) =>
                      song.title.toLowerCase().contains(query) ||
                      song.sngNumber == int.tryParse(query) ||
                      song.verse.toLowerCase().contains(query))
                  .toList();
          final songsList = songs.map((e) => e.songId).toSet();
          songs.retainWhere((x) => songsList.remove(x.songId));
          return songs;
        case MenuSelector.injili:
          songs = songs
              .where((song) => song.category == 'Nyimbo Za Injili')
              .toList();
          songs = query == 'query'
              ? songs
              : songs
                  .where((song) =>
                      song.title.toLowerCase().contains(query) ||
                      song.sngNumber == int.tryParse(query) ||
                      song.verse.toLowerCase().contains(query))
                  .toList();
          final songsList = songs.map((e) => e.songId).toSet();
          songs.retainWhere((x) => songsList.remove(x.songId));
          return songs;
        case MenuSelector.enyimba:
          songs = songs
              .where((song) => song.category == 'Enyimba Za Kristo')
              .toList();
          songs = query == 'query'
              ? songs
              : songs
                  .where((song) =>
                      song.title.toLowerCase().contains(query) ||
                      song.sngNumber == int.tryParse(query) ||
                      song.verse.toLowerCase().contains(query))
                  .toList();
          final songsList = songs.map((e) => e.songId).toSet();
          songs.retainWhere((x) => songsList.remove(x.songId));
          return songs;
        case MenuSelector.kikuyu:
          songs = songs
              .where((song) => song.category == 'Nyimbo Cia Kiroho')
              .toList();
          songs = query == 'query'
              ? songs
              : songs
                  .where((song) =>
                      song.title.toLowerCase().contains(query) ||
                      song.sngNumber == int.tryParse(query) ||
                      song.verse.toLowerCase().contains(query))
                  .toList();
          final songsList = songs.map((e) => e.songId).toSet();
          songs.retainWhere((x) => songsList.remove(x.songId));
          return songs;
        case MenuSelector.tenzi:
          songs = songs
              .where((song) => song.category == 'Tenzi Za Rohoni')
              .toList();
          songs = query == 'query'
              ? songs
              : songs
                  .where((song) =>
                      song.title.toLowerCase().contains(query) ||
                      song.sngNumber == int.tryParse(query) ||
                      song.verse.toLowerCase().contains(query))
                  .toList();
          final songsList = songs.map((e) => e.songId).toSet();
          songs.retainWhere((x) => songsList.remove(x.songId));
          print(songs.length);
          return songs;
        case MenuSelector.favsongs:
          songs = songs.where((song) => song.isFavorite == 1).toList();
          // songs = query == 'query'
          //     ? songs
          //     : songs
          //         .where((song) =>
          //             song.title.toLowerCase().contains(query) ||
          //             song.sngNumber == int.tryParse(query) ||
          //             song.verse.toLowerCase().contains(query))
          //         .toList();
          final songsList = songs.map((e) => e.category).toSet();
          songs.retainWhere((x) => songsList.remove(x.category));
          print('FAVS:: ${songs.length}');
          return songs;
        default:
          return songs;
      }
    },
    orElse: () => [],
  );
});

class SongsListNotifier extends StateNotifier<AsyncValue<List<Song>>> {
  SongsListNotifier(this._read) : super(const AsyncValue.loading()) {
    getSongs();
  }
  final Reader _read;
  //final Ref _ref;

  Future<void> getSongsByCategory() async {
    try {
      List<Song> songs = await _read(songsRepositoryProvider).getSongs();
      state = AsyncData(songs);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> getSongs() async {
    try {
      List<Song> songs = await _read(songsRepositoryProvider).getSongs();
      state = AsyncData(songs);
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
            if (item.songId == updatesong.songId &&
                item.category == updatesong.category)
              updatesong
            else
              item
        ]);
      });
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
