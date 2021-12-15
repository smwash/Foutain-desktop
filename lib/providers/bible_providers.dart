import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'general_providers.dart';

final getBooksProvider = StateNotifierProvider<GetBooksNotifier, List<Bible>>(
    (ref) => GetBooksNotifier(ref));

final getBChaptersProvider =
    StateNotifierProvider.family<GetBibleBkChaptersNotifier, List<Bible>, int>(
        (ref, int book) => GetBibleBkChaptersNotifier(ref, book));

// final setBbleVrsesProvider =
//     StateNotifierProvider.family<GetBibleVrsesNotifier, List<Bible>, Bible>(
//         (ref, bible) => GetBibleVrsesNotifier(ref, bible));

final setBibleProvider = StateProvider<Bible?>((ref) => null);
//final bibleVerseFlScrnProvider = StateProvider<Bible?>((ref) => null);

final getVrsesProvider =
    StateNotifierProvider<GetBibleVrsesNotifier, AsyncValue<List<Bible>>>(
        (ref) {
  final bible = ref.watch(setBibleProvider);
  return GetBibleVrsesNotifier(ref, bible!);
});

final bibleProvider = StateNotifierProvider<SetBibleNotifier, Bible?>(
    (ref) => SetBibleNotifier());
final bibleversesProvider =
    StateNotifierProvider<SetBibleVrsesNotifier, List<Bible>>(
        (ref) => SetBibleVrsesNotifier());

class SetBibleNotifier extends StateNotifier<Bible?> {
  SetBibleNotifier() : super(null);

  void setBible(Bible b) {
    state = b;
  }
}

class SetBibleVrsesNotifier extends StateNotifier<List<Bible>> {
  SetBibleVrsesNotifier() : super([]);

  void setBible(List<Bible> b) {
    state = b;
  }
}

class GetBooksNotifier extends StateNotifier<List<Bible>> {
  GetBooksNotifier(this._ref) : super([]) {
    getBibleBooks();
  }
  final Ref _ref;

  void getBibleBooks() async {
    MenuSelector menustate = _ref.watch(menuSelectorProvider.state).state;
    String query = _ref.watch(searchQueryProvider.state).state;

    if (menustate == MenuSelector.oldTest) {
      List<Bible> books = await _ref.watch(databaseProvider).getOldTest(1, 39);
      state = query == 'query'
          ? books
          : books.where((e) => e.bkName.toLowerCase().contains(query)).toList();
    }
    if (menustate == MenuSelector.newTest) {
      List<Bible> books = await _ref.watch(databaseProvider).getOldTest(40, 66);
      state = query == 'query'
          ? books
          : books.where((e) => e.bkName.toLowerCase().contains(query)).toList();
    }
  }
}

class GetBibleBkChaptersNotifier extends StateNotifier<List<Bible>> {
  GetBibleBkChaptersNotifier(this._ref, this.book) : super([]) {
    getBkChapters();
  }
  final Ref _ref;
  final int book;

  void getBkChapters() async {
    state = await _ref.watch(databaseProvider).getBkChapters(book);
  }
}

class GetBibleVrsesNotifier extends StateNotifier<AsyncValue<List<Bible>>> {
  GetBibleVrsesNotifier(this._ref, this._bible)
      : super(const AsyncValue.loading()) {
    getVerses();
  }
  final Ref _ref;
  final Bible _bible;

  void getVerses() async {
    List<Bible> verses =
        await _ref.watch(databaseProvider).getChaptVrss(_bible);
    state = AsyncData(verses);
  }
}

//final htmlDoc = parseHtmlDocument(content)