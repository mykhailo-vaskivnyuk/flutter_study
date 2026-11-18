import 'dart:async';
import 'dart:developer';

import 'package:flutter_app_first/my/data/local_storage.dart';
import 'package:flutter_app_first/my/models/item_model.dart';

class StorageRepository {
  StorageRepository();

  int _lastId = 0;
  final List<Item> _items = [];
  final _deletedItemsController = StreamController<Item>.broadcast();

  Stream<Item> get deletedItems => _deletedItemsController.stream;

  final LocalStorage<Map<String, dynamic>> _localStorage = LocalStorage(
    key: 'storageItems',
  );

  Future<void> _save() async {
    try {
      final jsonList = _items.map((item) => item.toJson()).toList();
      await _localStorage.saveData(jsonList);
    } catch (error, stackTrace) {
      log('Failed to save storage', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> initialize() async {
    final jsonList = await _localStorage.getData();

    _items.addAll(jsonList.map(Item.fromJson));
    _lastId = _items.lastOrNull?.id ?? 0;
  }

  List<Item> createItem(String name) {
    final item = Item(id: ++_lastId, name: name);

    _items.add(item);
    _save();

    return List.from(_items);
  }

  List<Item> removeItem(int id) {
    final item = getItem(id);

    if (item != null) {
      _items.remove(item);
      _deletedItemsController.add(item);
      _save();
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

  List<Item> getAllItems() {
    return List.from(_items);
  }

  void dispose() {
    _deletedItemsController.close();
  }
}
