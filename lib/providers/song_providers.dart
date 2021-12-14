import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/repositories/song_repository.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'general_providers.dart';

final currentSong = Provider<Song>((_) => throw UnimplementedError());
final categoryProvider = Provider<String>((_) => throw UnimplementedError());

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
  List<Song> songs = ref
      .watch(filteredSongListProvider)
      .where((song) => song.category == category)
      .toList();
  List<Song> searchResults = ref.watch(searchResultsProvider(songs));
  return searchResults.isEmpty ? songs : searchResults;
});

final songsRepositoryProvider =
    Provider<SongsRepository>((ref) => SongsRepository(ref.read));

final songsListStateProvider =
    StateNotifierProvider<SongsListNotifier, AsyncValue<List<Song>>>(
        (ref) => SongsListNotifier(ref.read));

final filteredSongListProvider = Provider<List<Song>>((ref) {
  final songListFilterState = ref.watch(menuSelectorProvider);
  final songListState = ref.watch(songsListStateProvider);
  return songListState.maybeWhen(
    data: (songs) {
      switch (songListFilterState) {
        case MenuSelector.hymn:
          songs = songs.where((song) => song.category == 'Hymn Book').toList();
          List<Song> searchResults = ref.watch(searchResultsProvider(songs));
          return searchResults.isEmpty ? songs : searchResults;
        case MenuSelector.injili:
          songs = songs
              .where((song) => song.category == 'Nyimbo Za Injili')
              .toList();
          List<Song> searchResults = ref.watch(searchResultsProvider(songs));
          return searchResults.isEmpty ? songs : searchResults;
        case MenuSelector.enyimba:
          songs = songs
              .where((song) => song.category == 'Enyimba Za Kristo')
              .toList();
          List<Song> searchResults = ref.watch(searchResultsProvider(songs));
          return searchResults.isEmpty ? songs : searchResults;
        case MenuSelector.kikuyu:
          songs = songs
              .where((song) => song.category == 'Nyimbo Cia Kiroho')
              .toList();
          List<Song> searchResults = ref.watch(searchResultsProvider(songs));
          return searchResults.isEmpty ? songs : searchResults;
        case MenuSelector.tenzi:
          songs = songs
              .where((song) => song.category == 'Tenzi Za Rohoni')
              .toList();
          List<Song> searchResults = ref.watch(searchResultsProvider(songs));
          return searchResults.isEmpty ? songs : searchResults;
        case MenuSelector.favsongs:
          return songs.where((song) => song.isFavorite == 1).toList();
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
      if (mounted) {
        state = AsyncData(songs);
      }
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

//SONG DETAIL
final songDetailProvider =
    StateNotifierProvider<SongDetailNotifier, AsyncValue<List<Song>>>((ref) {
  return SongDetailNotifier(ref.read);
});

class SongDetailNotifier extends StateNotifier<AsyncValue<List<Song>>> {
  SongDetailNotifier(this._read) : super(const AsyncValue.loading());
  final Reader _read;

  Future<void> setSongDetail(Song s) async {
    try {
      List<Song> songs = await _read(songsRepositoryProvider)
          .getSongsById(s.songId, s.category);
      state = AsyncData(songs);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
