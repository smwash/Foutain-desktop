import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/widgets/bible/wide_scrn_verses.dart';

import 'middle_scrn.dart';
import 'side_menu.dart';
import 'wide_scrn.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final screenState = ref.watch(mainScreenStateProvider);
    if (screenState == ScreenState.fullbible) {
      return const FullScreenVerse();
      //return Scaffold(body: Container(color: Colors.white));
    }
    if (screenState == ScreenState.fullsng) {
      return Scaffold(body: Container(color: Colors.white));
    } else {
      return Scaffold(
        body: Row(
          children: const [
            Expanded(
              flex: 2,
              child: SideMenu(),
            ),
            Expanded(
              flex: 3,
              child: MiddleScreen(),
            ),
            Expanded(
              flex: 5,
              child: WideScreen(),
            ),
          ],
        ),
      );
    }
  }
}
