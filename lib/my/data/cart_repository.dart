import 'package:flutter_app_first/my/data/shared_preferences.dart';

class CartRepository {
  CartRepository();

  final List<int> _items = [];

  final LocalStorage<int> _localStorage = LocalStorage(key: 'cartItems');

  Future<void> _save() async {
    await _localStorage.saveData(List<int>.from(_items));
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
