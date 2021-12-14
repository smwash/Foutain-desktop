import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:universal_html/parsing.dart';
import 'package:window_manager/window_manager.dart';

class BibleVrsScreen extends ConsumerWidget {
  const BibleVrsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final versesProvider = ref.watch(getVrsesProvider);
    final bible = ref.watch(setBibleProvider);
    return versesProvider.when(
      data: (verses) {
        return Container(
          color: Colors.white,
          //padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0.6,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text('${bible!.bkName} • ${bible.chapter}',
                    style: TextStyle(color: Colors.black)),
                actions: [
                  IconButton(
                    icon: Icon(Icons.fullscreen,
                        color: Theme.of(context).primaryColor),
                    onPressed: () async {
                      await WindowManager.instance.setFullScreen(
                          await WindowManager.instance.isFullScreen()
                              ? false
                              : true);
                    },
                  ),
                ],
              ),
              Expanded(
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
                                Text(
                                  bible.verse.toString(),
                                  style: TextStyle(fontSize: 16.sp),
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
                            ref.read(bibleVerseFlScrnProvider.notifier).state =
                                bible;
                            ref.read(mainScreenStateProvider.notifier).state =
                                ScreenState.fullbible;
                            await WindowManager.instance.setFullScreen(
                                await WindowManager.instance.isFullScreen()
                                    ? false
                                    : true);
                          }),
                    );
                  },
                ),
              )
            ],
          ),
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

class FullScreenVerse extends ConsumerWidget {
  const FullScreenVerse({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleVerseFlScrnProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(mainScreenStateProvider.notifier).state =
                    ScreenState.initial;
              },
              icon: Icon(Icons.fullscreen_exit,
                  color: Colors.black, size: 35.sp)),
          SizedBox(width: 20.w),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Text(
                '${bible!.bkName} ${bible.chapter}:${bible.verse}',
                style: TextStyle(fontSize: 45.sp),
              ),
              SizedBox(height: 100.h),
              Center(
                child: HtmlWidget(
                  bible.text,
                  textStyle: TextStyle(fontSize: 45.sp),
                  customStylesBuilder: (element) {
                    if (element.localName == 'em') {
                      return {
                        'color': 'red',
                        'font-style': 'normal',
                      };
                    }
                  },
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
