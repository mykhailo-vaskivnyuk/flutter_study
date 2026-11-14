import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select<CartCubit, int>(
      (cubit) => cubit.state.itemIds.length,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        tooltip: 'Open cart',
        onPressed: () {
          final cubit = context.read<CartCubit>()..updateItems();
          context.push('storage/cart', extra: cubit);
        },
        icon: Badge.count(
          count: count,
          isLabelVisible: count > 0,
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}
