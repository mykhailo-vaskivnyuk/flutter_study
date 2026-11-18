import 'package:flutter_app_first/my/cubits/storage_cubit.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StorageCubit', () {
    late StorageRepository repository;
    late StorageCubit cubit;

    setUp(() {
      repository = StorageRepository();
      cubit = StorageCubit(storageRepository: repository);
    });

    tearDown(() async {
      await cubit.close();
      repository.dispose();
    });

    test('starts empty', () {
      expect(cubit.state, isEmpty);
    });

    test('createItem emits a new list with the item', () {
      final before = cubit.state;

      cubit.createItem('A');

      expect(before, isEmpty);
      expect(cubit.state, isNot(same(before)));
      expect(cubit.state.single.name, 'A');
      expect(cubit.state.single.id, 1);
    });

    test('removeItem emits a list without the item', () {
      cubit
        ..createItem('A')
        ..createItem('B')
        ..removeItem(1);

      expect(cubit.state.map((i) => i.id), [2]);
    });
  });
}
