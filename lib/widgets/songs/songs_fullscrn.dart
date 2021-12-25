import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';
import 'package:foutain_desktop/utils/utilities.dart';
import 'package:window_manager/window_manager.dart';

class SongFullScreen extends ConsumerStatefulWidget {
  const SongFullScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SongFullScreenState();
}

class _SongFullScreenState extends ConsumerState<SongFullScreen> {
  final FocusNode focusNode = FocusNode();
  int storeVrs = 0;

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(songVersesProvider);
    final vrsNumber = ref.watch(verseCountProvider);
    final bgColor = ref.watch(colorProvider);
    final fontcolor = ref.watch(fontcolorProvider);
    final groupedsongs = songh(ref.watch(songdetailProvider));
    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (event) async {
        if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
          await WindowManager.instance.setFullScreen(false);
          ref.read(verseCountProvider.notifier).state = 1;
          ref.read(mainScreenStateProvider.notifier).state =
              ScreenState.initial;
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          // if (vrsNumber == songh(ref.read(songdetailProvider)).length &&
          //     songs.first.hasChorus == 1) {
          //   ref.read(verseCountProvider.notifier).state = 2;
          // }
          if (vrsNumber < songh(ref.read(songdetailProvider)).length) {
            ref.read(verseCountProvider.notifier).state++;
            // if (songs.first.hasChorus == 1) {
            //   if (vrsNumber > 2) {
            //     // if (vrsNumber == 3 && storeVrs == 2) {
            //     //   ref.read(verseCountProvider.notifier).state = 2;
            //     //   setState(() => storeVrs = 3);
            //     // }
            //     if (vrsNumber == 3 && storeVrs == 2) {
            //       ref.read(verseCountProvider.notifier).state = 2;
            //       //
            //       setState(() => storeVrs = 4);
            //     }
            //     if (vrsNumber == 3 && storeVrs == 4) {
            //       ref.read(verseCountProvider.notifier).state = 4;
            //       // setState(() =>
            //       //     storeVrs = ref.read(verseCountProvider.notifier).state);
            //     }
            //     if (vrsNumber == 2 && storeVrs == 4) {
            //       ref.read(verseCountProvider.notifier).state = 5;
            //       setState(() => storeVrs = 5);
            //     }
            //     if (vrsNumber == 5) {
            //       ref.read(verseCountProvider.notifier).state = 2;
            //       // setState(() =>
            //       //     storeVrs = ref.read(verseCountProvider.notifier).state);
            //     }
            //     if (vrsNumber == 2 && storeVrs == 5) {
            //       ref.read(verseCountProvider.notifier).state = 6;
            //       setState(() => storeVrs = 6);
            //     }

            //   } else {
            //     setState(() => storeVrs = 2);
            //   }
            // } else {
            //   ref.read(verseCountProvider.notifier).state++;
            // }
          }
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          if (vrsNumber != 1) {
            ref.read(verseCountProvider.notifier).state--;
          }
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          if (vrsNumber != 1) {
            ref.read(verseCountProvider.notifier).state = 2;
          }
        }
        if (event.isControlPressed &&
            event.isKeyPressed(LogicalKeyboardKey.add)) {
          print('Increase Fontsize');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
            elevation: 3,
            centerTitle: true,
            shadowColor: fontcolor,
            leadingWidth: double.infinity,
            backgroundColor: bgColor,
            title: Text(
              songs.first.title.toLowerCase().capitalizeFirstofEach,
              style: TextStyle(
                  color: fontcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(storeVrs.toString()),
              )
            ]),
        body: Column(
          children: [
            const Spacer(),
            ListView.builder(
              itemCount: songs.length,
              shrinkWrap: true,
              itemBuilder: (context, int i) {
                Song song = songs[i];
                return Center(
                  child: Text(
                    song.verse,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 50.sp,
                        height: 1.5,
                        color: fontcolor,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const Spacer(),
            Divider(color: fontcolor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 10,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      radius: 35.sp,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        songs.first.sngNumber.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        songs.first.hasChorus == 1 && vrsNumber == 2
                            ? 'Chorus'
                            : 'Verse  $vrsNumber',
                        style: TextStyle(
                          color: fontcolor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (groupedsongs.length != vrsNumber && vrsNumber != 1)
                        SizedBox(
                          width: 22.w,
                          child: Icon(Icons.arrow_drop_up,
                              size: 70.sp, color: fontcolor),
                        ),
                      Icon(
                          groupedsongs.length == vrsNumber
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 70.sp,
                          color: fontcolor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
