import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage<T extends Object> {
  LocalStorage({required this._key});

  final String _key;

  Future<List<T>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    if (raw == null) return [];

    return (jsonDecode(raw) as List).map((item) => item as T).toList();
  }

  Future<void> saveData(List<T> data) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(data);

    await prefs.setString(_key, raw);
  }
}
