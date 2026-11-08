import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateItemButton extends StatelessWidget {
  const CreateItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add item',
      onPressed: () {
        final cubit = context.read<StorageCubit>();
        context.push('storage/create-item', extra: cubit);
      },
      child: const Icon(Icons.add),
    );
  }
}
