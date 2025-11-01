// lib/screens/add_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../app_state.dart';
import 'list_screen.dart'; // ← чтобы заменить экран на список при pushReplacement

class AddFormScreen extends StatefulWidget {
  /// Совместимость со старой реализацией (если форма вызывалась с колбэками)
  final void Function(String title, String? note, String category)? onSaveLegacy;
  final VoidCallback? onCancelLegacy;

  const AddFormScreen({super.key, this.onSaveLegacy, this.onCancelLegacy});

  /// Для открытия через маршруты
  const AddFormScreen.routerMode({super.key})
      : onSaveLegacy = null,
        onCancelLegacy = null;

  @override
  State<AddFormScreen> createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String? _note;
  String _category = 'Общее';

  void _saveToState() {
    final app = AppScope.of(context);
    app.addItem(
      Item(
        title: _title,
        note: _note,
        createdAt: DateTime.now(), // обязателен в твоей модели
        category: _category,
        isBought: false,
      ),
    );
  }

  void _onBack() {
    widget.onCancelLegacy?.call();
    Navigator.pop(context); // вертикальная назад
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить покупку'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onBack,
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

            // 1) Сохранить: страничная горизонтальная (replace)
            FilledButton.tonal(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (widget.onSaveLegacy != null) {
                    widget.onSaveLegacy!(_title, _note, _category);
                  } else {
                    _saveToState();
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const ListScreen()),
                  );
                }
              },
              child: const Text('Сохранить (replace)'),
            ),
            const SizedBox(height: 8),

            // 2) Сохранить: маршрутизированная горизонтальная (go)
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (widget.onSaveLegacy != null) {
                    widget.onSaveLegacy!(_title, _note, _category);
                  } else {
                    _saveToState();
                  }
                  context.go('/');
                }
              },
              child: const Text('Сохранить (go)'),
            ),
          ],
        ),
      ),
    );
  }
}
