import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/pages/storage/create_item_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateItemButton extends StatelessWidget {
  const CreateItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add item',
      onPressed: () {
        final cubit = context.read<StorageCubit>();

        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: const CreateItemPage(),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
