import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/storage_cubit.dart';
import 'package:flutter_app_first/my/widgets/storage/cart_button.dart';
import 'package:flutter_app_first/my/widgets/storage/create_item_button.dart';
import 'package:flutter_app_first/my/widgets/storage/snack_bar.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_badge.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_item_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageView extends StatelessWidget {
  const StorageView({super.key});

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
            listenWhen: (previous, current) => previous.length > current.length,
            listener: (context, state) =>
                showSnackBar(context, 'item removed from storage'),
          ),
          BlocListener<StorageCubit, StorageCubitState>(
            listenWhen: (previous, current) => previous.length < current.length,
            listener: (context, state) =>
                showSnackBar(context, 'item added to storage'),
          ),
        ],
        child: StorageItemList(),
      ),
      floatingActionButton: const CreateItemButton(),
    );
  }
}
