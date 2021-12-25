import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

import 'bible_search_bkselector.dart';

class RecentSearchAllBooks extends ConsumerWidget {
  static void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: 'Edit Song',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return Consumer(
          builder: (context, ref, child) {
            return const RecentSearchAllBooks();
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  const RecentSearchAllBooks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookState = ref.watch(booksStateProvider);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.height * 0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'BOOKS',
                        style: TextStyle(
                            letterSpacing: 1.1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 20.w),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          overlayColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor.withOpacity(0.3)),
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.black54,
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              bookState == BookSelector.allBooks
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                        child: Text(
                          'All Books',
                          style: TextStyle(
                              color: bookState == BookSelector.allBooks
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onPressed: () {
                          ref.read(bookFilterProvider.notifier).state = '';
                          ref.read(booksStateProvider.notifier).state =
                              BookSelector.allBooks;
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close')),
                ],
              ),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BibleSearchBookSelector(),
                    VerticalDivider(),
                    BibleSearchBookSelector(isOldTest: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
