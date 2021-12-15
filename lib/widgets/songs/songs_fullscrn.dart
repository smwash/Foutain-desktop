import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/utilities.dart';
import 'package:window_manager/window_manager.dart';

class SongFullScreen extends ConsumerWidget {
  const SongFullScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songVersesProvider);

    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) async {
          if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
            await WindowManager.instance.setFullScreen(false);
            ref.read(mainScreenStateProvider.notifier).state =
                ScreenState.initial;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            ref.read(verseCountProvider.notifier).state++;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            if (ref.read(verseCountProvider) != songs.length) {
              ref.read(verseCountProvider.notifier).state--;
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.6,
            centerTitle: true,
            leadingWidth: double.infinity,
            // leading: Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Song:  ${songs.first.sngNumber}',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 30.sp,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       // WidgetSpan(
            //       //   child: Center(
            //       //     child: CircleAvatar(
            //       //       backgroundColor: Theme.of(context).primaryColor,
            //       //       child: Text(
            //       //         songs.first.sngNumber.toString(),
            //       //         style: TextStyle(
            //       //           color: Colors.white,
            //       //           //fontSize: 30.sp,
            //       //           fontWeight: FontWeight.bold,
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // )
            //     ],
            //   ),
            // ),
            backgroundColor: Colors.white,
            title: Text(songs.first.title.toLowerCase().capitalizeFirstofEach,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp)),
            // actions: [
            //   Center(
            //       child: Text('Verse: ${ref.watch(verseCountProvider)}',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 30.sp,
            //             fontWeight: FontWeight.bold,
            //           ))),
            //   SizedBox(width: 30.w),
            // ],
          ),
          body: Column(
            children: [
              Spacer(),
              ListView.builder(
                itemCount: songs.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int i) {
                  Song song = songs[i];
                  return Center(
                    child: Text(
                      song.verse,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 50.sp,
                          height: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              Spacer(),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FloatingActionButton(
                    //     onPressed: () {},
                    //     label: Text(
                    //       songs.first.sngNumber.toString(),
                    //       style: TextStyle(
                    //         //color: Colors.white,
                    //         fontSize: 30.sp,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     )),
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        songs.first.sngNumber.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Text.rich(
                    //   TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Song • ',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 30.sp,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       WidgetSpan(
                    //         child: Center(
                    //           child: CircleAvatar(
                    //             radius: 30.sp,
                    //             backgroundColor:
                    //                 Theme.of(context).colorScheme.secondary,
                    //             child: Text(
                    //               songs.first.sngNumber.toString(),
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 30.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Text(
                    //   'Song Number • ${songs.first.sngNumber}',
                    //   style: TextStyle(
                    //       fontSize: 28.sp, fontWeight: FontWeight.w600),
                    // ),
                    // CircleAvatar(
                    //   backgroundColor: Theme.of(context).primaryColor,
                    //   child: Text(
                    //     songs.first.sngNumber.toString(),
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       //fontSize: 30.sp,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Text('Verse  ${ref.watch(verseCountProvider)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    // Text('Verse - ${songs.first.sngNumber}'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
