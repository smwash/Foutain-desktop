import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'all_books.dart';

class BibleSearchSetter extends ConsumerWidget {
  const BibleSearchSetter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final testaSelector = ref.watch(testamentStateProvider);
    final bookState = ref.watch(booksStateProvider);
    final bookName = ref.watch(bookFilterProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 7.w))),
          child: Row(
            children: [
              if (bookState == BookSelector.single
                  ? false
                  : testaSelector == TestaSelector.bothOldNew ||
                      testaSelector == TestaSelector.oldTest)
                Icon(Icons.check, color: Colors.white, size: 16.sp),
              SizedBox(width: 5.w),
              Text('Old(Test)', style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          onPressed: () {
            if (testaSelector == TestaSelector.oldTest) {
              return;
            }
            if (testaSelector == TestaSelector.bothOldNew) {
              ref.read(testamentStateProvider.notifier).state =
                  TestaSelector.newTest;
            } else if (testaSelector == TestaSelector.newTest) {
              ref.read(testamentStateProvider.notifier).state =
                  TestaSelector.bothOldNew;
            }
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 7.w))),
          child: Row(
            children: [
              if (bookState == BookSelector.single
                  ? false
                  : testaSelector == TestaSelector.bothOldNew ||
                      testaSelector == TestaSelector.newTest)
                Icon(Icons.check, color: Colors.white, size: 16.sp),
              SizedBox(width: 5.w),
              Text('New(Test)', style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          onPressed: () {
            if (testaSelector == TestaSelector.newTest) {
              return;
            }
            if (testaSelector == TestaSelector.bothOldNew) {
              ref.read(testamentStateProvider.notifier).state =
                  TestaSelector.oldTest;
            } else if (testaSelector == TestaSelector.oldTest) {
              ref.read(testamentStateProvider.notifier).state =
                  TestaSelector.bothOldNew;
            }
          },
        ),
        ElevatedButton(
          child: Text(bookState == BookSelector.single ? bookName : 'All Books',
              style: TextStyle(color: Colors.black)),
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(color: Colors.black54)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => RecentSearchAllBooks.showDialog(context),
        ),
      ],
    );
  }
}
