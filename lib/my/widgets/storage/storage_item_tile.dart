import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/item_model.dart';

class StorageItemTile extends StatelessWidget {
  const StorageItemTile({
    required this.item,
    required this.inCart,
    required this.onAddToCart,
    required this.onDelete,
    super.key,
  });

  final Item item;
  final bool inCart;
  final VoidCallback onAddToCart;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: inCart,
      selectedTileColor: Theme.of(context).colorScheme.surfaceDim,
      title: Text(item.name),
      subtitle: Text('id: ${item.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Add to cart',
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: onAddToCart,
          ),
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
