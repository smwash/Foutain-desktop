import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

final currentBibleBookProvider =
    Provider<Bible>((ref) => throw UnimplementedError());

class BibleBooks extends ConsumerWidget {
  const BibleBooks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(getBooksProvider);
    final songsList = books.map((e) => e.bkNumber).toSet();
    books.retainWhere((x) => songsList.remove(x.bkNumber));
    return books.isEmpty
        ? Center(
            child: Text('No Record Found',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
          )
        : ListView.builder(
            itemCount: books.length,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              Bible book = books[index];
              return ProviderScope(
                overrides: [currentBibleBookProvider.overrideWithValue(book)],
                child: const BibleChapterTile(),
              );
            },
          );
  }
}

class BibleChapterTile extends ConsumerWidget {
  const BibleChapterTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final bible = ref.watch(setBibleProvider);
    final book = ref.watch(currentBibleBookProvider);
    final chapters = ref.watch(bookChaptersProvider(book));
    final songsList = chapters.map((e) => e.chapter).toSet();
    chapters.retainWhere((x) => songsList.remove(x.chapter));
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: bible != null
            ? bible.bkName == book.bkName
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.white
            : Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: ExpansionTile(
        title: Text(book.bkName),
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
            itemCount: chapters.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              Bible chapter = chapters[index];
              return IconButton(
                icon: Center(
                  child: Text(
                    chapter.chapter.toString(),
                  ),
                ),
                onPressed: () {
                  ref.read(setBibleProvider.notifier).state = chapter;
                  ref.read(widescrnstateProvider.notifier).state =
                      WideScrnState.bible;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
