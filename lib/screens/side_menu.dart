import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/widgets/settings.dart';
import 'package:foutain_desktop/widgets/songs/sd_menu_tile.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sngbkSelector = ref.watch(menuSelectorProvider.state);
    final ScrollController _scrollController = ScrollController();
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/applogo.png',
                    height: 30.h, fit: BoxFit.fitHeight),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fountain',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '- A Higher Plane',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.queue_music,
                                size: 20.sp,
                                color: Theme.of(context).primaryColor)),
                        const TextSpan(
                          text: '  Songs',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  MousedListTile(
                      label: 'Hymn Songs',
                      menuSelector: MenuSelector.hymn,
                      onTap: () => sngbkSelector.state = MenuSelector.hymn),
                  MousedListTile(
                      menuSelector: MenuSelector.enyimba,
                      label: 'Enyimba Za Kristo',
                      onTap: () => sngbkSelector.state = MenuSelector.enyimba),
                  MousedListTile(
                      menuSelector: MenuSelector.injili,
                      label: 'Nyimbo Za Injili',
                      onTap: () => sngbkSelector.state = MenuSelector.injili),
                  MousedListTile(
                      menuSelector: MenuSelector.kikuyu,
                      label: 'Nyimbo Cia Kiroho',
                      onTap: () => sngbkSelector.state = MenuSelector.kikuyu),
                  MousedListTile(
                      menuSelector: MenuSelector.tenzi,
                      label: 'Tenzi Za Rohoni',
                      onTap: () => sngbkSelector.state = MenuSelector.tenzi),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.menu_book,
                                size: 20.sp,
                                color: Theme.of(context).primaryColor)),
                        const TextSpan(
                          text: '  Bible',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  MousedListTile(
                      menuSelector: MenuSelector.oldTest,
                      label: 'Old Testament',
                      onTap: () {
                        ref.read(searchQueryProvider.notifier).state = 'query';
                        sngbkSelector.state = MenuSelector.oldTest;
                      }),
                  MousedListTile(
                      menuSelector: MenuSelector.newTest,
                      label: 'New Testament',
                      onTap: () {
                        ref.read(searchQueryProvider.notifier).state = 'query';
                        sngbkSelector.state = MenuSelector.newTest;
                      }),
                  MousedListTile(
                      menuSelector: MenuSelector.searchBible,
                      label: 'Search',
                      onTap: () {
                        ref.read(searchQueryProvider.notifier).state = 'query';
                        sngbkSelector.state = MenuSelector.searchBible;
                      }),
                ],
              ),
            ),
            //SizedBox(height: 15.sp),
            Divider(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.favorite,
                                size: 20.sp,
                                color: Theme.of(context).primaryColor)),
                        const TextSpan(
                          text: '  Favorites',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  MousedListTile(
                      menuSelector: MenuSelector.favsongs,
                      label: 'Songs',
                      onTap: () => sngbkSelector.state = MenuSelector.favsongs),
                  MousedListTile(
                      menuSelector: MenuSelector.favbible,
                      label: 'Bible',
                      onTap: () => sngbkSelector.state = MenuSelector.favbible),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            MouseRegion(
              child: ListTile(
                leading:
                    Icon(Icons.settings, color: Theme.of(context).primaryColor),
                title: Text('Settings', style: TextStyle(fontSize: 13.sp)),
                dense: true,
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 12.sp, color: Colors.black),
                onTap: () => Settings.showDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
