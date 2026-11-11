class CartRepository {
  CartRepository();

  final List<int> _items = [];

  void addItem(int id) {
    if (_items.any((item) => item == id)) {
      return;
    }
    _items.add(id);
  }

  void removeItem(int id) {
    _items.remove(id);
  }

  bool hasItem(int id) {
    return _items.contains(id);
  }

  List<int> get items => [..._items];
}
