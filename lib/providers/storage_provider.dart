import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  late SharedPreferences _store;
  Future init() async {
    _store = await SharedPreferences.getInstance();
  }

  Object? get(String key) {
    return _store.get(key);
  }

  String? getString(String key) {
    return _store.getString(key);
  }

  List<String>? getStringList(String key) {
    return _store.getStringList(key);
  }

  Future<bool> setStringList(String key, List<String> list) {
    return _store.setStringList(key, list);
  }

  bool? getBool(String key) {
    return _store.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _store.setBool(key, value);
  }

  Future<bool> setString(String key, String value) {
    return _store.setString(key, value);
  }
}
