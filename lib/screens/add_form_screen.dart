import 'package:flutter/material.dart';

class AddFormScreen extends StatefulWidget {
  final Function(String, String?) onSave;
  final VoidCallback onCancel;

  const AddFormScreen({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<AddFormScreen> createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_titleController.text, _noteController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить покупку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название товара'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Введите название' : null,
              ),
              TextFormField(
                controller: _noteController,
                decoration:
                const InputDecoration(labelText: 'Комментарий (необязательно)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Сохранить'),
              ),
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Отмена'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
