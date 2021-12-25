import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:window_manager/window_manager.dart';

class BibleVrsScreen extends ConsumerWidget {
  const BibleVrsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final verses = ref.watch(getBVersesByChapterProvider);
    final bible = ref.watch(setBibleProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          elevation: 0.6,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('${bible!.bkName} • ${bible.chapter}',
              style: const TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 3.h),
        Expanded(
            child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: verses.length,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            itemBuilder: (BuildContext context, int index) {
              Bible bible = verses[index];
              return MouseRegion(
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              bible.verse.toString(),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            if (bible.isBkMarked == 1)
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
                        Expanded(
                            child: HtmlWidget(
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
                        )),
                      ],
                    ),
                  ),
                  onTap: () async {
                    ref.read(setFullscnBibleProvider.notifier).state = bible;
                    ref.read(fullScnbibleversesProvider.notifier).state =
                        verses;
                    ref.read(mainScreenStateProvider.notifier).state =
                        ScreenState.fullbible;
                    await WindowManager.instance.setFullScreen(true);
                  },
                  onLongPress: () async {
                    int? bkMarked = bible.isBkMarked == 0 ? 1 : 0;
                    await ref
                        .read(getBibleProvider.notifier)
                        .updateBible(bible.copyWith(isBkMarked: bkMarked));
                  },
                ),
              );
            },
          ),
        ))
      ],
    );
  }
}
