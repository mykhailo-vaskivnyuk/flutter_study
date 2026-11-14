import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
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
      body: BlocConsumer<CartCubit, CartCubitState>(
        listenWhen: (previous, current) =>
            previous.itemIds.length > current.itemIds.length,
        listener: (context, state) {
          context.read<CartCubit>().updateItems();
        },
        buildWhen: (previous, current) =>
            previous.items.length > current.items.length,
        builder: (context, state) {
          final items = state.items;

          if (items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CartItemTile(
                item: item,
                onDelete: () => context.read<CartCubit>().removeItemId(item.id),
              );
            },
          );
        },
      ),
    );
  }
}
