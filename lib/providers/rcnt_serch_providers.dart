import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/recent_srchs.dart';
import 'package:foutain_desktop/repositories/rcnt_srch_repository.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/vrs_srch.dart';

import 'bible_providers.dart';

final rcntSearchRepositoryProvider =
    Provider<RecentSearchRepository>((ref) => RecentSearchRepository(ref.read));

final searchControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final searchResultsCountsProvider = StateProvider<int>((ref) => 0);

final showRecentSearchesProvider = StateProvider<bool>((ref) => true);

final rcntSearchProvider = StateProvider<String>((ref) => 'query');

final bookFilterProvider = StateProvider<String>((ref) => '');

final booksStateProvider =
    StateProvider<BookSelector>((ref) => BookSelector.allBooks);
final testamentStateProvider =
    StateProvider<TestaSelector>((ref) => TestaSelector.bothOldNew);

// final groupedBooksProvider = FutureProvider<List<Bible>>((ref) async {
//   return ;
// });

// final recntSearchListProvider = FutureProvider<List<RecentSrch>>((ref) async {
//   List<RecentSrch> words =
//       await ref.watch(rcntSearchRepositoryProvider).getRcntSrch();
//   return words;
// });

final getAllChaptersProvider = Provider<List<Bible>>((ref) {
  return ref.watch(testaListProvider);
});

final recntSearchListProvider = StateNotifierProvider<GetRecentSearchNotifier,
    AsyncValue<List<RecentSrch>>>((ref) {
  return GetRecentSearchNotifier(ref.read);
});

class GetRecentSearchNotifier
    extends StateNotifier<AsyncValue<List<RecentSrch>>> {
  GetRecentSearchNotifier(this._read) : super(const AsyncValue.loading()) {
    getRecentSearchList();
  }

  final Reader _read;

  Future<void> getRecentSearchList() async {
    try {
      List<RecentSrch> data =
          await _read(rcntSearchRepositoryProvider).getRcntSrch();

      state = AsyncData(data);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addRecentSearch(int results) async {
    try {
      //state = const AsyncValue.loading();
      // int results = _read(searchWordFromBibleProvider)
      //     .maybeWhen(data: (data) => data.length, orElse: () => 0);
      RecentSrch s =
          RecentSrch(query: _read(rcntSearchProvider), results: results);
      int id = await _read(rcntSearchRepositoryProvider).addRcntSearch(s);
      state.whenData((data) => null);
      state.whenData((data) {
        data.removeWhere((word) => word.id == id);
        return state = AsyncData(data..add(s.copyWith(id: id)));
      });
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> deleteRecentSearch(RecentSrch s) async {
    try {
      await _read(rcntSearchRepositoryProvider).deleteRcntSrch(s);
      state.whenData((data) =>
          state = AsyncData(data..removeWhere((search) => search.id == s.id)));
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> deleteAllRecentSearch() async {
    try {
      await _read(rcntSearchRepositoryProvider).deleteAllRcntSearch();
      state.whenData((data) => state = const AsyncData([]));
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final searchWordFromBibleProvider = FutureProvider<List<Bible>>((ref) async {
  final testamentSelector = ref.watch(testamentStateProvider);
  final bookState = ref.watch(booksStateProvider);
  final bookSelectedState = ref.watch(bookFilterProvider);
  final query = ref.watch(rcntSearchProvider);
  List<Bible> data = await ref.watch(bibleRepositoryProvider).getAllBooks();
  if (bookState == BookSelector.allBooks &&
      testamentSelector == TestaSelector.bothOldNew) {
    if (query != 'query') {
      await ref
          .read(recntSearchListProvider.notifier)
          .addRecentSearch(verseSearcher(query, data).length);
    }
    return verseSearcher(query, data);
  }
  if (bookState == BookSelector.allBooks &&
      testamentSelector == TestaSelector.newTest) {
    List<Bible> books =
        data.where((e) => e.bkNumber > 39 && e.bkNumber <= 66).toList();
    await ref
        .read(recntSearchListProvider.notifier)
        .addRecentSearch(verseSearcher(query, data).length);
    return verseSearcher(query, books);
  }
  if (bookState == BookSelector.allBooks &&
      testamentSelector == TestaSelector.oldTest) {
    List<Bible> books =
        data.where((e) => e.bkNumber >= 1 && e.bkNumber <= 39).toList();
    return verseSearcher(query, books);
  }
  if (bookState == BookSelector.single) {
    List<Bible> books =
        data.where((e) => e.bkName == bookSelectedState).toList();
    return verseSearcher(query, books);
  } else {
    print('Length:: ${data.length}');
    return data;
  }
});
