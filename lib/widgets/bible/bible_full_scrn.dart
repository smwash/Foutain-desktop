import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:window_manager/window_manager.dart';

class FullScreenVerse extends ConsumerStatefulWidget {
  const FullScreenVerse({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FullScreenVerseState();
}

class _FullScreenVerseState extends ConsumerState<FullScreenVerse> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bible = ref.watch(setFullscnBibleProvider);

    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (event) async {
        if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
          await WindowManager.instance.setFullScreen(false);
          ref.read(mainScreenStateProvider.notifier).state =
              ScreenState.initial;
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          final list = ref.read(fullScnbibleversesProvider);
          if (bible!.verse == list.last.verse) return;

          if (bible.verse != list.last.verse) {
            String text = list
                .where((e) =>
                    e.verse == bible.verse + 1 &&
                    e.chapter == bible.chapter &&
                    e.bkName == bible.bkName)
                .first
                .text;
            ref.read(setFullscnBibleProvider.notifier).state =
                (bible.copyWith(verse: bible.verse + 1, text: text));
          }
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          final list = ref.read(fullScnbibleversesProvider);
          if (bible!.verse == list.first.verse) return;
          if (bible.verse != list.first.verse) {
            String text = list
                .where((e) =>
                    e.verse == bible.verse - 1 &&
                    e.chapter == bible.chapter &&
                    e.bkName == bible.bkName)
                .first
                .text;
            ref.read(setFullscnBibleProvider.notifier).state =
                (bible.copyWith(verse: bible.verse - 1, text: text));
          }
        }
      },
      child: Scaffold(
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
              //Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
