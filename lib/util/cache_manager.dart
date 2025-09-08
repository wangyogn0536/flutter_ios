import 'package:shared_preferences/shared_preferences.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:轻量级储存信息类
class CacheManager {
  static SharedPreferences? _preferences;

  CacheManager._();

  CacheManager._pre(SharedPreferences preferences) {
    _preferences = preferences;
  }

  static CacheManager? _instance;

  static CacheManager? getInstance() {
    _instance ??= CacheManager._();
    return _instance;
  }

  //预初始化，防止get时，SharedPreferences还未初始化完毕
  static Future<CacheManager?> preInit() async {
    if (_instance == null) {
      var preferences = await SharedPreferences.getInstance();
      _instance = CacheManager._pre(preferences);
    }
    return _instance;
  }

  set(String key, Object value) {
    if (value is int) {
      _preferences?.setInt(key, value);
    } else if (value is String) {
      _preferences?.setString(key, value);
    } else if (value is double) {
      _preferences?.setDouble(key, value);
    } else if (value is bool) {
      _preferences?.setBool(key, value);
    } else if (value is List<String>) {
      _preferences?.setStringList(key, value);
    } else {
      throw Exception("only Support int、String、double、bool、List<String>");
    }
  }

  Object? get<T>(String key) {
    return _preferences?.get(key);
  }

  ///全部删除
  static CacheManager? clear() {
    _preferences?.clear();
    _preferences?.commit();
  }

  static CacheManager? clearKey(String key) {
    _preferences?.remove(key);
  }
}

// class AppStorage {
//   static final AppStorage _singleton = AppStorage._internal();
//   static SharedPreferences? _prefs;
//
//   factory AppStorage() {
//     return _singleton;
//   }
//   AppStorage._internal();
//   Future<bool> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     return _prefs != null;
//   }
//
//   Future<void> setString(String key, String value) async {
//     await _prefs?.setString(key, value);
//   }
//
//   Future<String?> getString(String key) async {
//     return _prefs?.getString(key);
//   }
//
//   Future<void> remove(String key) async {
//     await _prefs?.remove(key);
//   }
// }
