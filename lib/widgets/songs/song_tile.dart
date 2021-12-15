import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/utilities.dart';

import 'fav_songs.dart';

class SongsByCategory extends ConsumerWidget {
  const SongsByCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final catSongs =
        ref.watch(favSongsByCategoryProvider(ref.watch(categoryProvider)));
    return ListView.builder(
      itemCount: catSongs.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        Song catsong = catSongs[index];
        return ProviderScope(
          overrides: [currentSong.overrideWithValue(catsong)],
          child: const SongTile(),
        );
      },
    );
  }
}

class SongTile extends ConsumerWidget {
  const SongTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final catsong = ref.watch(currentSong);
    return Padding(
      key: ValueKey(catsong.id),
      padding: EdgeInsets.only(bottom: 5.h),
      child: ListTile(
        dense: true,
        tileColor: Theme.of(context).canvasColor,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.17),
          child: Text(
            catsong.sngNumber.toString(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        title: Text(
          catsong.title.toLowerCase().capitalizeFirstofEach,
        ),
        subtitle: Text(catsong.verse),
        trailing: IconButton(
          color: catsong.isFavorite == 1
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.8),
          icon: Icon(catsong.isFavorite == 1
              ? Icons.favorite
              : Icons.favorite_outline),
          onPressed: () async {
            await ref.read(songsListStateProvider.notifier).updateSong(
                catsong.copyWith(isFavorite: catsong.isFavorite == 1 ? 0 : 1));
          },
        ),
        onTap: () async {
          ref.read(widescrnstateProvider.notifier).state = WideScrnState.song;
        },
      ),
    );
  }
}
