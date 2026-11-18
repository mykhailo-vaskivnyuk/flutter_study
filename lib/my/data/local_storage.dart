import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage<T extends Object> {
  LocalStorage({required this._key});

  final _prefs = SharedPreferencesAsync();
  final String _key;

  Future<List<T>> getData() async {
    final str = await _prefs.getString(_key);

    if (str == null) {
      return <T>[];
    }
    final json = jsonDecode(str) as List;
    return json.map((item) => item as T).toList();
  }

  Future<void> saveData(List<T> json) async {
    final str = jsonEncode(json);

    await _prefs.setString(_key, str);
  }
}
