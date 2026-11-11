import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageBadge extends StatelessWidget {
  const StorageBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select<StorageCubit, int>(
      (state) => state.state.storageItems.length,
    );

    return Badge.count(
      count: count,
      isLabelVisible: count > 0,
      child: const Icon(Icons.inventory_2_outlined),
    );
  }
}
