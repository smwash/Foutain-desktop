import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';
import 'package:foutain_desktop/utils/utilities.dart';
import 'package:foutain_desktop/widgets/bible/wide_scrn_verses.dart';

class WideScreen extends ConsumerWidget {
  const WideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrnstateProvider = ref.watch(widescrnstateProvider.state).state;
    if (scrnstateProvider == WideScrnState.song) {
      final songProvider = ref.watch(songDetailProvider);
      return songProvider.when(
          data: (songs) {
            Song song = songs.first;
            return Container(
              color: Colors.white,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    elevation: 0.6,
                    centerTitle: true,
                    leading: Center(
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.17),
                        child: Text(
                          song.sngNumber.toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    title: Text(song.title.toLowerCase().capitalizeFirstofEach,
                        style: const TextStyle(color: Colors.black)),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border,
                            color: Theme.of(context).primaryColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.fullscreen,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: Scrollbar(
                      //controller: scollBarController,
                      isAlwaysShown: true,
                      child: ListView.builder(
                        key: const PageStorageKey<String>('Sng_dtl'),
                        itemCount: songh(songs).values.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          List<Song> solos =
                              songh(songs).values.toList()[index];
                          int vrsNum = songh(songs).keys.toList()[index];
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  song.hasChorus == 1 && vrsNum == 2
                                      ? '[Chorus]'
                                      : solos[0].verse == 'CHORUS'
                                          ? '[Chorus]'
                                          : '[Verse $vrsNum]',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      //fontSize: fontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10.h),
                                ListView.builder(
                                  itemCount: solos.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, int i) {
                                    return solos[i].verse == 'CHORUS'
                                        ? const SizedBox.shrink()
                                        : Center(
                                            child: Text(
                                              solos[i].verse,
                                              style: const TextStyle(
                                                  //fontSize: fontSize,
                                                  height: 1.5),
                                            ),
                                          );
                                  },
                                ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          );
                        },
                      ),
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
              ));
    } else if (scrnstateProvider == WideScrnState.bible) {
      return const BibleVrsScreen();
    }
    return Container(color: Colors.white);
  }

  //ScrollController scollBarController = ScrollController();
}
