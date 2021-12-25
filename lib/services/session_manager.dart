import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionManagerProvider =
    Provider<SessionManager>((ref) => throw UnimplementedError());

class SessionManager {
  SessionManager(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  double getFlScrnFntSz() =>
      sharedPreferences.getDouble(Keys.fullscreenFntSize) ?? 50.sp;

  Color getSnBgColor() {
    int? val = sharedPreferences.getInt(Keys.songBgColor);
    if (val != null) {
      return Color(val);
    }
    return Colors.white;
  }

  Color getSngFntColor() {
    int? val = sharedPreferences.getInt(Keys.songFntColor);
    if (val != null) {
      return Color(val);
    }
    return Colors.white;
  }

  Future setFlScrnFntSize(double val) async {
    await sharedPreferences.setDouble(Keys.fullscreenFntSize, val);
  }

  Future setSnBgColor(Color val) async {
    await sharedPreferences.setInt(Keys.songBgColor, val.value);
  }

  Future setSngFntColor(Color val) async {
    await sharedPreferences.setInt(Keys.songFntColor, val.value);
  }
}
