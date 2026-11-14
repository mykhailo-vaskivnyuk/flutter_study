import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_app_first/my/cubits/storage_cubit.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageItemList extends StatelessWidget {
  const StorageItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select<StorageCubit, List<Item>>(
      (cubit) => cubit.state,
    );
    final cartItemIds = context.select<CartCubit, List<int>>(
      (cubit) => cubit.state.itemIds,
    );

    if (items.isEmpty) {
      return const Center(child: Text('No items yet'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final id = item.id;
        final inCart = cartItemIds.contains(id);

        return StorageItemTile(
          item: item,
          inCart: inCart,
          onAddToCart: () => context.read<CartCubit>().addItemId(id),
          onDelete: () => context.read<StorageCubit>().removeItem(id),
        );
      },
    );
  }
}
