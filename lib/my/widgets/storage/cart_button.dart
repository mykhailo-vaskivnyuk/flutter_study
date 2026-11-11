import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_cubit.dart';
import 'package:flutter_app_first/my/pages/storage/cart_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StorageCubit>();
    final count = context.select<StorageCubit, int>(
      (state) => state.state.cartItemsCount,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        tooltip: 'Open cart',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) =>
                  BlocProvider.value(value: cubit, child: const CartPage()),
            ),
          );
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
