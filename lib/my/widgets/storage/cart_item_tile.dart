import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/item_model.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, required this.onDelete, super.key});

  final Item item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('id: ${item.id}'),
      trailing: IconButton(
        tooltip: 'Remove from cart',
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
