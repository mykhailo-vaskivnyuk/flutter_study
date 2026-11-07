import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageItemList extends StatelessWidget {
  const StorageItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<Item>>(
      builder: (context, cart) {
        final storageCubit = context.read<StorageCubit>();
        final items = storageCubit.state.items;
        final cartCubit = context.read<CartCubit>();
        final cartIds = cart.map((item) => item.id).toSet();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final inCart = cartIds.contains(item.id);
            return StorageItemTile(
              item: item,
              inCart: inCart,
              onAddToCart: () => _addToCart(context, item, inCart),
              onDelete: () {
                storageCubit.removeItem(item.id);
                cartCubit.removeItem(item.id);
              },
            );
          },
        );
      },
    );
  }

  void _addToCart(BuildContext context, Item item, bool inCart) {
    context.read<CartCubit>().addItem(item);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            inCart
                ? '"${item.name}" is already in the cart'
                : '"${item.name}" added to cart',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      );
  }
}
