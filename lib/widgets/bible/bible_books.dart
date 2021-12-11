import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

class BibleBooks extends ConsumerWidget {
  const BibleBooks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(getBooksProvider);
    return ListView.builder(
      itemCount: books.length,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        Bible book = books[index];
        final chapters = ref.watch(getBChaptersProvider(book.bkNumber));
        return Container(
          margin: EdgeInsets.only(bottom: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: ExpansionTile(
            title: Text(book.bkName),
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
                itemCount: chapters.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return IconButton(
                    icon: Center(
                      child: Text(
                        chapters[index].chapter.toString(),
                      ),
                    ),
                    onPressed: () {
                      List<Bible> vrses = ref.read(setBbleVrsesProvider(book));

                      ref.read(getVrsesProvider.notifier).state = vrses;
                      ref.read(widescrnstateProvider.notifier).state =
                          WideScrnState.bible;
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
