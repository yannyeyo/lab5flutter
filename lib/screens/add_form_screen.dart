import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../navigation/routes.dart';
import '../di/locator.dart';
import '../services/item_service.dart';

class AddFormScreen extends StatefulWidget {
  const AddFormScreen({super.key});
  const AddFormScreen.routerMode({super.key});

  @override
  State<AddFormScreen> createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String? _note;
  String _category = 'Общее';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить покупку'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Название'),
              textInputAction: TextInputAction.next,
              onSaved: (v) => _title = v!.trim(),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Введите название' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Примечание'),
              textInputAction: TextInputAction.next,
              onSaved: (v) => _note = v?.trim(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Категория'),
              onSaved: (v) {
                final t = (v ?? '').trim();
                _category = t.isEmpty ? 'Общее' : t;
              },
            ),
            const SizedBox(height: 24),

            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  final item = Item(
                    title: _title,
                    note: _note,
                    createdAt: DateTime.now(),
                    category: _category,
                    isBought: false,
                  );

                  di<ItemService>().add(item);
                  context.go(Routes.home);
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
