import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/utilities.dart';

class SongCard extends ConsumerStatefulWidget {
  const SongCard({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SongCardState();
}

class _SongCardState extends ConsumerState<SongCard> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(filteredSongListProvider);
    return songs.isEmpty
        ? const Center(
            child: Text('No record found'),
          )
        : Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: ListView.builder(
              itemCount: songs.length,
              controller: _scrollController,
              key: const PageStorageKey<String>('Sng_Lst'),
              itemBuilder: (BuildContext context, int index) {
                Song catsong = songs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: MouseRegion(
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.17),
                        child: Text(
                          catsong.sngNumber.toString(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                          catsong.title.toLowerCase().capitalizeFirstofEach),
                      subtitle: Text(catsong.verse),
                      trailing: IconButton(
                        color: catsong.isFavorite == 1
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.8),
                        icon: Icon(
                            catsong.isFavorite == 1
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 20.sp),
                        onPressed: () async {
                          await ref
                              .read(songsListStateProvider.notifier)
                              .updateSong(catsong.copyWith(
                                  isFavorite: catsong.isFavorite == 1 ? 0 : 1));
                        },
                      ),
                      onTap: () async {
                        ref.read(songSetterProvider.notifier).state = catsong;
                        ref.read(widescrnstateProvider.notifier).state =
                            WideScrnState.song;
                      },
                    ),
                  ),
                );
              },
            ),
          );
  }
}
