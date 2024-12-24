import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys {
  firstName,
  lastName,
  email,
  token,
  admin,
  isDark,
  customer,
  userId,
  isLogin,
  isSubscribe
}
bool? isLogin = false;
String? email = "";
class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putBool(SharedKeys key, value) {
    sharedPreferences.setBool(key.name, value ?? false);
  }

  static getBool(SharedKeys key) {
    return sharedPreferences.getBool(key.name) ?? false;
  }

  static putString(SharedKeys key, value) {
    sharedPreferences.setString(key.name, value ?? '');
  }

  static getString(SharedKeys key) {
    return sharedPreferences.getString(key.name) ?? "";
  }
}
