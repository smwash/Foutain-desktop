import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/song_providers.dart';

import 'song_tile.dart';

class FavoriteSongs extends ConsumerWidget {
  const FavoriteSongs({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsListState = ref.watch(songsListStateProvider);
    final filteredSongs = ref.watch(filteredSongListProvider);
    return songsListState.when(
      data: (songs) {
        // final songsList = filteredSongs.map((e) => e.category).toSet();
        // filteredSongs.retainWhere((x) => songsList.remove(x.category));
        return songs.isEmpty
            ? const Center(child: Text('No record found'))
            : ListView.builder(
                itemCount: filteredSongs.length,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  Song song = filteredSongs[index];

                  // final songsList = catSongs.map((e) => e.songId).toSet();
                  // catSongs.retainWhere((x) => songsList.remove(x.songId));
                  return ProviderScope(
                    overrides: [
                      categoryProvider.overrideWithValue(song.category)
                    ],
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, right: 12.w, left: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 15.w),
                            child: Text(song.category,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 4.h),
                          const SongsByCategory(),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
      error: (e, st) {
        return Center(child: Text('ERROR: $e'));
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
