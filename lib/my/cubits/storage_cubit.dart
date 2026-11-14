import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef StorageCubitState = List<Item>;

class StorageCubit extends Cubit<StorageCubitState> {
  StorageCubit({
    required this._storageRepository,
  }) : super(const []);

  final StorageRepository _storageRepository;

  void createItem(String name) {
    emit(_storageRepository.createItem(name));
  }

  void removeItem(int id) {
    emit(_storageRepository.removeItem(id));
  }
}
