import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/recent_srchs.dart';
import 'package:foutain_desktop/providers/bible_providers.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/utilities.dart';

import 'all_books.dart';
import 'bible_search_setter.dart';

class RecentSearchMiddleScrn extends ConsumerStatefulWidget {
  const RecentSearchMiddleScrn({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecentSearchMiddleScrnState();
}

class _RecentSearchMiddleScrnState
    extends ConsumerState<RecentSearchMiddleScrn> {
  @override
  Widget build(BuildContext context) {
    final searchListState = ref.watch(recntSearchListProvider);
    final showSearchList = ref.watch(showRecentSearchesProvider);
    final searchresultsState = ref.watch(searchWordFromBibleProvider);
    final query = ref.watch(rcntSearchProvider);
    return showSearchList
        ? searchListState.when(
            data: (searchList) {
              searchList.sort((a, b) => b.id!.compareTo(a.id!));
              return searchList.isEmpty
                  ? const Center(
                      child: Text('No record found'),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('RECENT SEARCH',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextButton(
                              child: const Text('CLEAR'),
                              onPressed: () async {
                                await ref
                                    .read(recntSearchListProvider.notifier)
                                    .deleteAllRecentSearch();
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: searchList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              RecentSrch search = searchList[index];
                              return ListTile(
                                title: Text(search.query),
                                trailing: Text(search.results.toString()),
                                onTap: () {
                                  ref.read(rcntSearchProvider.notifier).state =
                                      search.query;
                                  ref
                                      .read(searchControllerProvider.notifier)
                                      .state
                                      .text = search.query;
                                  ref
                                      .read(showRecentSearchesProvider.notifier)
                                      .state = false;
                                },
                              );
                            },
                          ),
                        ),
                      ],
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
          )
        : searchresultsState.when(
            data: (searchresults) {
              return searchresults.isEmpty
                  ? Column(
                      children: const [
                        BibleSearchSetter(),
                        Spacer(),
                        Center(
                          child: Text('No record found'),
                        ),
                        Spacer(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BibleSearchSetter(),
                        SizedBox(height: 10.h),
                        Text(
                            searchresults.length > 1
                                ? '${searchresults.length} Results'
                                : '${searchresults.length} Result',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: ListView.builder(
                            itemCount: searchresults.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              Bible bible = searchresults[index];
                              return MouseRegion(
                                child: GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 5.h),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${bible.bkName} ${bible.chapter}:${bible.verse}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 7.w),
                                          HtmlWidget(
                                            stringToHtml(bible.text, query),
                                            textStyle:
                                                TextStyle(fontSize: 15.sp),
                                            customStylesBuilder: (element) {
                                              if (element.localName == 'em') {
                                                return {
                                                  'color': 'red',
                                                  'font-style': 'normal',
                                                };
                                              }
                                              if (element.localName == 'b') {
                                                return {
                                                  'color': 'orange',
                                                  //'font-style': 'normal',
                                                };
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      ref
                                          .read(setBibleProvider.notifier)
                                          .state = bible;
                                      ref
                                          .read(widescrnstateProvider.notifier)
                                          .state = WideScrnState.bible;
                                    }),
                              );
                            },
                          ),
                        ),
                      ],
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
