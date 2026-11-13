import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_app_first/my/cubits/storage_cubit.dart';
import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => StorageRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => StorageCubit(
              storageRepository: RepositoryProvider.of<StorageRepository>(ctx),
            ),
          ),
          BlocProvider(
            create: (ctx) => CartCubit(
              storageRepository: RepositoryProvider.of<StorageRepository>(ctx),
              cartRepository: CartRepository(),
            ),
          ),
        ],
        child: const StorageView(),
      ),
    );
  }
}
