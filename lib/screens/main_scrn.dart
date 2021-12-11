import 'package:flutter/material.dart';

import 'middle_scrn.dart';
import 'side_menu.dart';
import 'wide_scrn.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
