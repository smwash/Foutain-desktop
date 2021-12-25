import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';
import 'package:foutain_desktop/utils/utilities.dart';
import 'package:window_manager/window_manager.dart';

import 'edit_song.dart';

class SongWideScreen extends ConsumerStatefulWidget {
  const SongWideScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SongWideScreenState();
}

class _SongWideScreenState extends ConsumerState<SongWideScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(songdetailProvider);
    Song song = songs.first;
    return Container(
      color: Colors.white,
      child: Column(
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
                color: song.isFavorite == 1
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.8),
                icon: Icon(
                    song.isFavorite == 1
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    size: 20.sp),
                onPressed: () async {
                  await ref.read(songsListStateProvider.notifier).updateSong(
                      song.copyWith(isFavorite: song.isFavorite == 1 ? 0 : 1));
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
              //   onPressed: () {
              //     EditSong.showDialog(context);
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.fullscreen,
                    color: Theme.of(context).primaryColor),
                onPressed: () async {
                  ref.read(mainScreenStateProvider.notifier).state =
                      ScreenState.fullsng;
                  await WindowManager.instance.setFullScreen(true);
                },
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: ListView.builder(
                key: const PageStorageKey<String>('Sng_dtl'),
                itemCount: songh(songs).values.length,
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  List<Song> solos = songh(songs).values.toList()[index];
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
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10.h),
                        ListView.builder(
                          itemCount: solos.length,
                          shrinkWrap: true,
                          //controller: scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, int i) {
                            return solos[i].verse == 'CHORUS'
                                ? const SizedBox.shrink()
                                : Center(
                                    child: Text(
                                      solos[i].verse,
                                      style: TextStyle(
                                          fontSize: 18.sp, height: 1.5),
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
}
