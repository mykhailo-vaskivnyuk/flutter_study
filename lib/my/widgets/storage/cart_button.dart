import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/pages/storage/cart_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartCubit>().state;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        tooltip: 'Open cart',
        onPressed: () {
          final cartCubit = context.read<CartCubit>();
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) =>
                  BlocProvider.value(value: cartCubit, child: const CartPage()),
            ),
          );
        },
        icon: Badge.count(
          count: cart.length,
          isLabelVisible: cart.isNotEmpty,
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}
