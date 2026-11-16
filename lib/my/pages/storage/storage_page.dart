import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_app_first/my/cubits/storage_cubit.dart';
import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/widgets/storage/storage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  bool _isRepositoriesInited = false;
  final StorageRepository _storageRepository = StorageRepository();
  final CartRepository _cartRepository = CartRepository();

  @override
  void initState() {
    super.initState();
    _initRepositories();
  }

  Future<void> _initRepositories() async {
    await _storageRepository.initialize();
    await _cartRepository.initialize();
    await Future<void>.delayed(const Duration(seconds: 1));
    _isRepositoriesInited = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRepositoriesInited) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _storageRepository),
        RepositoryProvider(create: (_) => _cartRepository),
      ],
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
              cartRepository: RepositoryProvider.of<CartRepository>(ctx),
            ),
          ),
        ],
        child: const StorageView(),
      ),
    );
  }
}
