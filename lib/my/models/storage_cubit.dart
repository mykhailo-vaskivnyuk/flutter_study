import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef StorageCubitState = ({List<Item> storageItems, int cartItemsCount});

class StorageCubit extends Cubit<StorageCubitState> {
  StorageCubit({
    required this._storageRepository,
    required this._cartRepository,
  }) : super(const (storageItems: [], cartItemsCount: 0));

  final StorageRepository _storageRepository;
  final CartRepository _cartRepository;

  void createItem(String itemName) {
    _storageRepository.createItem(itemName);
    emit((
      storageItems: _storageRepository.items,
      cartItemsCount: state.cartItemsCount,
    ));
  }

  void removeItem(int id) {
    _storageRepository.removeItem(id);
    _cartRepository.removeItem(id);
    emit((
      storageItems: _storageRepository.items,
      cartItemsCount: _cartRepository.items.length,
    ));
  }

  void addItemToCart(int id) {
    _cartRepository.addItem(id);
    emit((
      storageItems: state.storageItems,
      cartItemsCount: _cartRepository.items.length,
    ));
  }

  bool isItemInCart(int id) {
    return _cartRepository.hasItem(id);
  }

  void removeItemFromCart(int id) {
    _cartRepository.removeItem(id);
    emit((
      storageItems: state.storageItems,
      cartItemsCount: _cartRepository.items.length,
    ));
  }

  List<Item> getCartItems() {
    final items = _cartRepository.items
        .map(_storageRepository.getItem)
        .whereType<Item>()
        .toList();
    return items;
  }
}
