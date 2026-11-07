import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
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
      body: BlocBuilder<CartCubit, List<Item>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          final cartCubit = context.read<CartCubit>();

          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final item = cart[index];
              return CartItemTile(
                item: item,
                onDelete: () => cartCubit.removeItem(item.id),
              );
            },
          );
        },
      ),
    );
  }
}
