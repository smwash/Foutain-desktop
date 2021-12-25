import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/widgets/bible/bible_bkmarks.dart';
import 'package:foutain_desktop/widgets/bible/bible_books.dart';
import 'package:foutain_desktop/widgets/bible/rcnt_search_scrn.dart';
import 'package:foutain_desktop/widgets/songs/fav_songs.dart';
import 'package:foutain_desktop/widgets/songs/song_card.dart';

class MiddleScreen extends ConsumerStatefulWidget {
  const MiddleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MiddleScreenState();
}

class _MiddleScreenState extends ConsumerState<MiddleScreen> {
  // @override
  // void dispose() {
  //   ref.read(searchControllerProvider).dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(menuSelectorProvider.state).state;
    final _searchController = ref.watch(searchControllerProvider);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _searchController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Search',
                          border: InputBorder.none),
                      onChanged: (val) {
                        if (menuState != MenuSelector.searchBible) {
                          ref.read(searchQueryProvider.notifier).state = val;
                        }
                        if (val.isEmpty) {
                          ref.read(showRecentSearchesProvider.notifier).state =
                              true;
                        }
                      },
                      onSubmitted: (val) async {
                        if (menuState == MenuSelector.searchBible) {
                          ref.read(rcntSearchProvider.notifier).state = val;
                          ref.read(showRecentSearchesProvider.notifier).state =
                              false;

                          //print(ref.read(searchWordFromBibleProvider).value);
                          // await ref
                          //     .read(recntSearchListProvider.notifier)
                          //     .addRecentSearch();

                          //.addRcntSearch();
                        }
                      }),
                ),
                MouseRegion(
                  child: GestureDetector(
                    child: Icon(Icons.close,
                        size: 20.sp, color: Theme.of(context).primaryColor),
                    onTap: () {
                      _searchController.clear();
                      ref.read(showRecentSearchesProvider.notifier).state =
                          true;
                      ref.read(searchQueryProvider.notifier).state = 'query';
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          if (menuState == MenuSelector.newTest ||
              menuState == MenuSelector.oldTest)
            const Expanded(
              child: BibleBooks(),
            ),
          if (menuState == MenuSelector.kikuyu ||
              menuState == MenuSelector.enyimba ||
              menuState == MenuSelector.injili ||
              menuState == MenuSelector.hymn ||
              menuState == MenuSelector.tenzi)
            const Expanded(
              child: SongCard(),
            ),
          if (menuState == MenuSelector.favsongs)
            const Expanded(
              child: FavoriteSongs(),
            ),
          if (menuState == MenuSelector.searchBible)
            const Expanded(
              child: RecentSearchMiddleScrn(),
            ),
          if (menuState == MenuSelector.favbible)
            const Expanded(
              child: BibleBookmarks(),
            ),
        ],
      ),
    );
  }
}
