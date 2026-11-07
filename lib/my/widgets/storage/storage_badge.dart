import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageBadge extends StatelessWidget {
  const StorageBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<StorageCubit>().state;

    return Badge.count(
      count: storage.items.length,
      isLabelVisible: storage.items.isNotEmpty,
      child: const Icon(Icons.inventory_2_outlined),
    );
  }
}
