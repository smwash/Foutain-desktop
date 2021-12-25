import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/main_scrn.dart';
import 'services/session_manager.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(1000, 540));
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    sessionManagerProvider.overrideWithValue(
      SessionManager(sharedPreferences),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1200, 768),
        builder: () {
          return MaterialApp(
            title: 'Fountain',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColor: kLightPrimaryColor,
              scaffoldBackgroundColor: kLightScaffoldColor,
              colorScheme: const ColorScheme.light().copyWith(
                  primary: kLightPrimaryColor, secondary: kLightSecondaryColor),
              primarySwatch: Colors.blue,
            ),
            home: const MainScreen(),
          );
        });
  }
}
