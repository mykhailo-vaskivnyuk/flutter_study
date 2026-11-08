import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/widgets/storage/create_item_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Create Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateItemForm(
          formKey: _formKey,
          nameController: _nameController,
          onSave: _save,
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<StorageCubit>();
      final items = cubit.state.items;
      final nextId = items.isEmpty ? 1 : items.last.id + 1;
      final name = _nameController.text.trim();

      cubit.addItem(Item(id: nextId, name: name));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              '"$name" added to storage',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),
        );

      Navigator.pop(context);
    }
  }
}
