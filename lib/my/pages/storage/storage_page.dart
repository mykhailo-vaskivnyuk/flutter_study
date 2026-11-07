import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/widgets/storage/cart_button.dart';
import 'package:flutter_app_first/my/widgets/storage/create_item_button.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_badge.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StorageCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: const _StorageView(),
    );
  }
}

class _StorageView extends StatelessWidget {
  const _StorageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Storage Page'),
        actions: [
          const StorageBadge(),
          const SizedBox(width: 24),
          const CartButton(),
        ],
      ),
      body: BlocBuilder<StorageCubit, StorageModel>(
        builder: (context, storage) {
          final items = storage.items;

          if (items.isEmpty) {
            return const Center(child: Text('No items yet'));
          }

          return StorageItemList();
        },
      ),
      floatingActionButton: const CreateItemButton(),
    );
  }
}
