import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

class BibleBookmarks extends ConsumerWidget {
  const BibleBookmarks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bkmarksState = ref.watch(bkmarkListProvider);
    final query = ref.watch(searchQueryProvider);
    return bkmarksState.when(
      data: (bkmarks) {
        bkmarks = query == 'query'
            ? bkmarks
            : bkmarks
                .where((e) => e.bkName.toLowerCase().contains(query))
                .toList();
        return bkmarks.isEmpty
            ? Center(
                child: Text(
                  'No Record Found',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                itemCount: bkmarks.length,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  Bible bible = bkmarks[index];
                  return MouseRegion(
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${bible.bkName} ${bible.chapter}:${bible.verse}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ),
                                GestureDetector(
                                    child: Icon(Icons.bookmark,
                                        color: Theme.of(context).primaryColor),
                                    onTap: () async {
                                      int? bkMarked =
                                          bible.isBkMarked == 0 ? 1 : 0;
                                      await ref
                                          .read(getBibleProvider.notifier)
                                          .updateBible(bible.copyWith(
                                              isBkMarked: bkMarked));
                                    }),
                              ],
                            ),
                            SizedBox(width: 7.w),
                            HtmlWidget(
                              bible.text,
                              textStyle: TextStyle(fontSize: 15.sp),
                              customStylesBuilder: (element) {
                                if (element.localName == 'em') {
                                  return {
                                    'color': 'red',
                                    'font-style': 'normal',
                                  };
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        ref.read(setBibleProvider.notifier).state = bible;
                        ref.read(widescrnstateProvider.notifier).state =
                            WideScrnState.bible;
                      },
                    ),
                  );
                },
              );
      },
      error: (e, st) {
        return Center(
          child: Text('ERROR: $e'),
        );
      },
      loading: () => Center(
        child: SpinKitThreeInOut(
          color: Theme.of(context).primaryColor,
          size: 50.sp,
        ),
      ),
    );
  }
}
