import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_app_first/my/models/storage_cubit.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageItemList extends StatelessWidget {
  const StorageItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StorageCubit>();
    final items = context.select<StorageCubit, List<Item>>(
      (state) => state.state.storageItems,
    );
    context.select<StorageCubit, int>(
      (state) => state.state.cartItemsCount,
    );

    if (items.isEmpty) {
      return const Center(child: Text('No items yet'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final id = item.id;
        final inCart = cubit.isItemInCart(id);
        return StorageItemTile(
          item: item,
          inCart: inCart,
          onAddToCart: () => cubit.addItemToCart(id),
          onDelete: () => cubit.removeItem(id),
        );
      },
    );
  }
}
