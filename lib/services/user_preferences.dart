import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUserEmail = 'user_email';
  static const _keyUserPassword = 'user_password';
  static const _keyRemember = 'remember';
  static const _keyTheme = 'theme';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setUserEmail(String email) async => await _preferences?.setString(_keyUserEmail, email);
  static Future setUserPassword(String password) async =>
      await _preferences?.setString(_keyUserPassword, password);
  static Future setRemember(bool remember) async => await _preferences?.setBool(_keyRemember, remember);
  static Future setTheme(String theme) async => await _preferences?.setString(_keyTheme, theme);

  static Future clear() async => await _preferences?.clear();

  static String? getUserEmail() => _preferences?.getString(_keyUserEmail);
  static String? getUserPassword() => _preferences?.getString(_keyUserPassword);
  static bool? getRemember() => _preferences?.getBool(_keyRemember);
  static String? getTheme() => _preferences?.getString(_keyTheme);
}
