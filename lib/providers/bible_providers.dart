import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/repositories/bible_repository.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'general_providers.dart';

final bibleRepositoryProvider =
    Provider<BibleRepository>((ref) => BibleRepository(ref.read));
final setBibleProvider = StateProvider<Bible?>((_) => null);
final setFullscnBibleProvider = StateProvider<Bible?>((_) => null);
final fullScnbibleversesProvider = StateProvider<List<Bible>>((_) => []);

final getBibleProvider =
    StateNotifierProvider<GetBibleNotifier, AsyncValue<List<Bible>>>(
        (ref) => GetBibleNotifier(ref.read));

class GetBibleNotifier extends StateNotifier<AsyncValue<List<Bible>>> {
  GetBibleNotifier(this._read) : super(const AsyncValue.loading()) {
    getBible();
  }

  final Reader _read;

  Future<void> getBible() async {
    try {
      List<Bible> data = await _read(bibleRepositoryProvider).getAllBooks();
      state = AsyncValue.data(data);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateBible(Bible b) async {
    try {
      await _read(bibleRepositoryProvider).updateBible(b);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == b.id) b else item
        ]);
      });
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final versesListProvider = Provider<List<Bible>>((ref) {
  final bibleListState = ref.watch(getBibleProvider);
  return bibleListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final chapterListProvider = StateProvider<List<Bible>>((ref) {
  final bibleListState = ref.watch(getBibleProvider);
  return bibleListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final testaListProvider = Provider<List<Bible>>((ref) {
  final bibleListState = ref.watch(getBibleProvider);
  return bibleListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final bibleBkmarkProvider = Provider<List<Bible>>((ref) {
  final bibleListState = ref.watch(getBibleProvider);
  return bibleListState.maybeWhen(data: (data) => data, orElse: () => []);
});

final bkmarkListProvider = Provider<AsyncValue<List<Bible>>>((ref) {
  return AsyncValue.data(
      ref.watch(bibleBkmarkProvider).where((e) => e.isBkMarked == 1).toList());
});

final bookChaptersProvider = Provider.family<List<Bible>, Bible>((ref, bible) {
  return ref
      .watch(chapterListProvider)
      .where((e) => e.bkNumber == bible.bkNumber)
      .toList();
});

final getBVersesByChapterProvider = Provider<List<Bible>>((ref) {
  final bible = ref.watch(setBibleProvider);
  return ref
      .watch(versesListProvider)
      .where((e) => e.bkNumber == bible!.bkNumber && e.chapter == bible.chapter)
      .toList();
});

final getBooksProvider = Provider<List<Bible>>((ref) {
  final menuState = ref.watch(menuSelectorProvider);
  final query = ref.watch(searchQueryProvider);
  List<Bible> listState = ref.watch(testaListProvider);
  switch (menuState) {
    case MenuSelector.oldTest:
      listState =
          listState.where((e) => e.bkNumber >= 1 && e.bkNumber <= 39).toList();
      listState = query == 'query'
          ? listState
          : listState
              .where((e) => e.bkName.toLowerCase().contains(query))
              .toList();
      return listState;
    case MenuSelector.newTest:
      listState =
          listState.where((e) => e.bkNumber > 39 && e.bkNumber <= 66).toList();
      listState = query == 'query'
          ? listState
          : listState
              .where((e) => e.bkName.toLowerCase().contains(query))
              .toList();
      return listState;
    default:
      return listState;
  }
});
