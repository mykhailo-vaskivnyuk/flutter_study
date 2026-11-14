import 'dart:async';

import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef CartCubitState = ({List<Item> items, List<int> itemIds});

class CartCubit extends Cubit<CartCubitState> {
  CartCubit({
    required this._storageRepository,
    required this._cartRepository,
  }) : super(const (items: [], itemIds: [])) {
    _subscribe();
  }

  final StorageRepository _storageRepository;
  final CartRepository _cartRepository;
  StreamSubscription<Item>? _deletedItemsSubscription;

  void _subscribe() {
    _deletedItemsSubscription = _storageRepository.deletedItems.listen((item) {
      removeItemId(item.id);
    });
  }

  @override
  Future<void> close() {
    _deletedItemsSubscription?.cancel();
    return super.close();
  }

  void addItemId(int id) {
    emit((
      items: state.items,
      itemIds: _cartRepository.addItem(id),
    ));
  }

  void removeItemId(int id) {
    emit((
      items: state.items,
      itemIds: _cartRepository.removeItem(id),
    ));
  }

  void updateItems() {
    final items = state.itemIds
        .map(_storageRepository.getItem)
        .whereType<Item>()
        .toList();

    emit((
      items: items,
      itemIds: state.itemIds,
    ));
  }
}
