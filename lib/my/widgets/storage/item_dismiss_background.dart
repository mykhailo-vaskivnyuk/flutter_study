import 'package:flutter/material.dart';

class ItemDismissBackground extends StatelessWidget {
  const ItemDismissBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.outline,
      alignment: .centerRight,
      padding: const EdgeInsets.only(right: 16),
      child: Icon(Icons.delete_outline, color: colors.onPrimary),
    );
  }
}
