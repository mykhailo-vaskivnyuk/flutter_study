import 'dart:developer';

import 'package:flutter_app_first/my/data/local_storage.dart';

class CartRepository {
  CartRepository();

  final List<int> _items = [];

  final LocalStorage<int> _localStorage = LocalStorage(key: 'cartItems');

  Future<void> _save() async {
    try {
      await _localStorage.saveData(List<int>.from(_items));
    } catch (error, stackTrace) {
      log('Failed to save cart', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> initialize() async {
    final items = await _localStorage.getData();
    _items.addAll(items);
  }

  List<int> addItem(int id) {
    if (!_items.contains(id)) {
      _items.add(id);
      _save();
    }

    return List.from(_items);
  }

  List<int> removeItem(int id) {
    _items.remove(id);
    _save();

    return List.from(_items);
  }

  List<int> getAllItems() {
    return List.from(_items);
  }
}
