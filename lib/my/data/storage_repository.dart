import 'dart:async';

import 'package:flutter_app_first/my/models/item_model.dart';

class StorageRepository {
  StorageRepository();

  int _lastId = 0;
  final List<Item> _items = [];
  final _deletedItemsController = StreamController<Item>.broadcast();

  Stream<Item> get deletedItems => _deletedItemsController.stream;

  List<Item> createItem(String name) {
    final item = Item(id: ++_lastId, name: name);

    _items.add(item);

    return List.from(_items);
  }

  List<Item> removeItem(int id) {
    final item = getItem(id);

    if (item != null) {
      _items.remove(item);
      _deletedItemsController.add(item);
    }

    return List.from(_items);
  }

  Item? getItem(int id) {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) {
      return null;
    }

    return _items[index];
  }

  void dispose() {
    _deletedItemsController.close();
  }
}
