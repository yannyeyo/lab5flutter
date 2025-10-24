import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/category_icons.dart';

class AddFormScreen extends StatefulWidget {
  final Function(String, String?, String) onSave;
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
  String? _selectedCategory;

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      widget.onSave(
        _titleController.text,
        _noteController.text,
        _selectedCategory!,
      );
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите тип товара')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить покупку')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название товара'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Введите название' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                    labelText: 'Комментарий (необязательно)'),
              ),
              const SizedBox(height: 20),

              Text(
                'Выберите тип товара',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              // Сетка категорий
              GridView.count(
                crossAxisCount: 5,
                childAspectRatio: 1,
                shrinkWrap: true,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                physics: const NeverScrollableScrollPhysics(),
                children: kCategories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return InkWell(
                    onTap: () => setState(() => _selectedCategory = cat),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        color: isSelected
                            ? theme.colorScheme.primary.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.05),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: categoryIcon(cat),
                            height: 46,
                            width: 46,
                            fit: BoxFit.contain,
                            placeholder: (c, u) => const SizedBox(
                              height: 46,
                              width: 46,
                              child: Center(
                                  child: CircularProgressIndicator(strokeWidth: 2)),
                            ),
                            errorWidget: (c, u, e) => const Icon(Icons.error),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cat,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall!.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
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
