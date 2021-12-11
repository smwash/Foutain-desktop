import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/extensions.dart';
import 'package:foutain_desktop/utils/utilities.dart';

class FavoriteSongs extends ConsumerWidget {
  const FavoriteSongs({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsListState = ref.watch(songsListStateProvider);
    final filteredSongs = ref.watch(filteredSongListProvider);
    return songsListState.when(
      data: (songs) {
        return songs.isEmpty
            ? const Center(
                child: Text('No record found'),
              )
            : ListView.builder(
                itemCount: filteredSongs.length,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  Song song = filteredSongs[index];
                  List<Song> catSongs =
                      ref.watch(favSongsByCategoryProvider(song.category));
                  // final songsList = catSongs.map((e) => e.category).toSet();
                  // catSongs.retainWhere((x) => songsList.remove(x.category));
                  return Container(
                    // padding:
                    //     EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    margin:
                        EdgeInsets.only(bottom: 10.h, right: 12.w, left: 12.w),
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
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: 4.h),
                        ListView.builder(
                          itemCount: catSongs.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            Song catsong = catSongs[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: ListTile(
                                  dense: true,
                                  tileColor: Theme.of(context).canvasColor,
                                  leading: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.17),
                                    child: Text(
                                      catsong.sngNumber.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    catsong.title
                                        .toLowerCase()
                                        .capitalizeFirstofEach,
                                  ),
                                  subtitle: Text(catsong.verse),
                                  trailing: IconButton(
                                    color: catsong.isFavorite == 1
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.8),
                                    icon: Icon(catsong.isFavorite == 1
                                        ? Icons.favorite
                                        : Icons.favorite_outline),
                                    onPressed: () async {
                                      Song sng = Song(
                                          id: song.id,
                                          verse: song.verse,
                                          title: song.title,
                                          songId: song.songId,
                                          lnNumber: song.lnNumber,
                                          sngNumber: song.sngNumber,
                                          vrsNumber: song.vrsNumber,
                                          hasChorus: song.hasChorus,
                                          isFavorite: 0,
                                          category: song.category);
                                      // setState(() {
                                      //   song.isFavorite = 0;
                                      // });
                                      // await db.updateSong(sng);
                                    },
                                  ),
                                  onTap: () async {
                                    ref
                                        .read(widescrnstateProvider.notifier)
                                        .state = WideScrnState.song;
                                    await ref
                                        .read(songDetailProvider.notifier)
                                        .setSongDetail(song);
                                  }),
                            );
                          },
                        )
                      ],
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
