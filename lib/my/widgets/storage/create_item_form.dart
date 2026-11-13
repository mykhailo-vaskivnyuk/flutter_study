import 'package:flutter/material.dart';

class CreateItemForm extends StatelessWidget {
  const CreateItemForm({
    required this.formKey,
    required this.nameController,
    required this.onSave,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: nameController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Please enter a name'
                : null,
            onFieldSubmitted: (_) => onSave(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onSave, child: const Text('Save')),
        ],
      ),
    );
  }
}
