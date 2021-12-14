import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:universal_html/parsing.dart';

class BibleBooks extends ConsumerWidget {
  const BibleBooks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(getBooksProvider);
    final bible = ref.watch(setBibleProvider);
    return ListView.builder(
      itemCount: books.length,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        Bible book = books[index];
        final chapters = ref.watch(getBChaptersProvider(book.bkNumber));
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
                      //List<Bible> vrses = ref.read(setBbleVrsesProvider(book));

                      ref.read(setBibleProvider.notifier).state = chapter;
                      ref.read(widescrnstateProvider.notifier).state =
                          WideScrnState.bible;
                      final htmldoc = parseHtmlDocument(book.text);
                      //print(htmldoc.);
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
