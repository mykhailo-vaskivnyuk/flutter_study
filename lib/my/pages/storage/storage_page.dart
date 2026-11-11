import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/models/storage_cubit.dart';
import 'package:flutter_app_first/my/widgets/storage/cart_button.dart';
import 'package:flutter_app_first/my/widgets/storage/create_item_button.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_badge.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StorageCubit(
        storageRepository: StorageRepository(),
        cartRepository: CartRepository(),
      ),
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<StorageCubit, StorageCubitState>(
            listenWhen: (previous, current) =>
                previous.storageItems.length < current.storageItems.length,
            listener: (context, state) =>
                _showSnackBar(context, 'item added to storage'),
          ),
          BlocListener<StorageCubit, StorageCubitState>(
            listenWhen: (previous, current) =>
                previous.storageItems.length > current.storageItems.length,
            listener: (context, state) =>
                _showSnackBar(context, 'item removed from storage'),
          ),
        ],
        child: StorageItemList(),
      ),
      floatingActionButton: const CreateItemButton(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      );
  }
}
