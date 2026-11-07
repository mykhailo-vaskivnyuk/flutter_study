import 'package:flutter_bloc/flutter_bloc.dart';

class Item {
  Item({required this.name, required this.id});

  final String name;
  final int id;
}

class StorageModel {
  StorageModel();

  StorageModel.from(StorageModel other) {
    _items.addAll(other.items);
  }

  final List<Item> _items = [];

  void addItem(Item item) {
    _items.add(item);
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
  }

  void getItem(int id) {
    _items.firstWhere((item) => item.id == id);
  }

  List<Item> get items {
    return _items;
  }
}

class StorageCubit extends Cubit<StorageModel> {
  StorageCubit() : super(StorageModel());

  void addItem(Item item) {
    emit(StorageModel.from(state)..addItem(item));
  }

  void removeItem(int id) {
    emit(StorageModel.from(state)..removeItem(id));
  }
}

class CartCubit extends Cubit<List<Item>> {
  CartCubit() : super(const []);

  void addItem(Item item) {
    if (state.any((i) => i.id == item.id)) {
      return;
    }
    emit(List.unmodifiable([...state, item]));
  }

  void removeItem(int id) {
    final newState = state.where((item) => item.id != id);
    emit(List.unmodifiable(newState));
  }
}
