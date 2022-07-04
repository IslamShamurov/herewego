import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _pref;

  static Future<void> inIt() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Object? getData(StorageKey key) {
    return _pref!.getString(key.name);
  }

  static Future<void> removeData(StorageKey key) async {
    await _pref!.remove(key.name);
  }

  static Future<void> setData(StorageKey key, Object value) async {
    switch (key) {
      case StorageKey.uid:
        {
          await _pref!.setString(StorageKey.uid.name, value as String);
        }
    }
  }
}

enum StorageKey { uid }
