import 'package:foutain_desktop/utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  bool isUserLoggedIn() => sharedPreferences.getBool(Keys.userLogin) ?? false;

  Future setVisitingValue(bool val) async {
    sharedPreferences.setBool(Keys.userLogin, val);
  }
}
