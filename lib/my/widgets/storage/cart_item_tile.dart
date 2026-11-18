import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_app_first/my/widgets/storage/item_dismiss_background.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, required this.onDelete, super.key});

  final Item item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: .endToStart,
      onDismissed: (_) => onDelete(),
      background: const ItemDismissBackground(),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('id: ${item.id}'),
        trailing: IconButton(
          tooltip: 'Remove from cart',
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
