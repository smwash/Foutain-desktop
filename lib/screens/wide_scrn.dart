import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';
import 'package:foutain_desktop/utils/utilities.dart';

class WideScreen extends ConsumerWidget {
  const WideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrnstateProvider = ref.watch(widescrnstateProvider.state).state;
    if (scrnstateProvider == WideScrnState.song) {
      final songProvider = ref.watch(songDetailProvider);
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
                    songProvider!.first.sngNumber.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text(
                  songProvider.first.title.toLowerCase().capitalizeFirstofEach,
                  style: TextStyle(color: Colors.black)),
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
                isAlwaysShown: true,
                child: ListView.builder(
                  key: const PageStorageKey<String>('Sng_dtl'),
                  itemCount: songh(songProvider).values.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    List<Song> solos =
                        songh(songProvider).values.toList()[index];
                    int vrsNum = songh(songProvider).keys.toList()[index];
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            songProvider.first.hasChorus == 1 && vrsNum == 2
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
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int i) {
                              return solos[i].verse == 'CHORUS'
                                  ? SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        '${solos[i].verse}',
                                        style: TextStyle(
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
    }
    return Container(
      color: Colors.white,
      //padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            elevation: 0.6,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.fullscreen,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ref.watch(getVrsesProvider.state).state.length,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                Bible bible = ref.watch(getVrsesProvider.state).state[index];
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        bible.verse.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Expanded(child: Text(bible.text))
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
