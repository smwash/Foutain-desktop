import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

class BibleSearchBookSelector extends ConsumerWidget {
  const BibleSearchBookSelector({
    Key? key,
    this.isOldTest = true,
  }) : super(key: key);

  final bool isOldTest;

  @override
  Widget build(BuildContext context, ref) {
    final booksList = ref.watch(getAllChaptersProvider);
    final book = ref.watch(bookFilterProvider);
    final list = booksList.map((e) => e.bkNumber).toSet();
    booksList.retainWhere((x) => list.remove(x.bkNumber));
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isOldTest ? 'Old Testament' : 'New Testament',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Wrap(
            runSpacing: 8.h,
            spacing: 15.w,
            children: booksList
                .where((e) => isOldTest
                    ? e.bkNumber >= 1 && e.bkNumber <= 39
                    : e.bkNumber > 39 && e.bkNumber <= 66)
                .map(
                  (bible) => ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.3)),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.black54,
                      )),
                      backgroundColor: MaterialStateProperty.all(
                          book == bible.bkName
                              ? Theme.of(context).primaryColor
                              : Colors.white),
                    ),
                    child: Text(
                      bible.bkName,
                      style: TextStyle(
                          color: book == bible.bkName
                              ? Colors.white
                              : Colors.black),
                    ),
                    onPressed: () {
                      ref.read(bookFilterProvider.notifier).state =
                          bible.bkName;
                      ref.read(booksStateProvider.notifier).state =
                          BookSelector.single;
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
