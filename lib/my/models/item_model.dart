class Item {
  const Item({required this.name, required this.id});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(name: json['name'] as String, id: json['id'] as int);
  }

  final String name;
  final int id;

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }
}
