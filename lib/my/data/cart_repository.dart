class CartRepository {
  CartRepository();

  final List<int> _items = [];

  List<int> addItem(int id) {
    if (!_items.contains(id)) {
      _items.add(id);
    }

    return List.from(_items);
  }

  List<int> removeItem(int id) {
    _items.remove(id);

    return List.from(_items);
  }
}
