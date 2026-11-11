import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_cubit.dart';
import 'package:flutter_app_first/my/widgets/storage/cart_item_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cart'),
      ),
      body: BlocBuilder<StorageCubit, StorageCubitState>(
        buildWhen: (previous, current) =>
            previous.cartItemsCount > current.cartItemsCount,
        builder: (context, state) {
          final cubit = context.read<StorageCubit>();
          final items = cubit.getCartItems();

          if (items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CartItemTile(
                item: item,
                onDelete: () => cubit.removeItemFromCart(item.id),
              );
            },
          );
        },
      ),
    );
  }
}
