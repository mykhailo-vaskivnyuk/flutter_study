import 'package:flutter_app_first/my/models/item_model.dart';

class StorageRepository {
  StorageRepository();

  final List<Item> _items = [];
  int _lastId = 0;

  void createItem(String name) {
    final id = ++_lastId;
    final item = Item(id: id, name: name);

    _items.add(item);
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
  }

  Item? getItem(int id) {
    final hasItem = _items.any((item) => item.id == id);

    if (!hasItem) {
      return null;
    }

    return _items.firstWhere((item) => item.id == id);
  }

  List<Item> get items {
    return List.from(_items);
  }
}
