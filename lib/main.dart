import 'package:flutter/material.dart';
import '/models/item.dart';
import 'screens/list_screen.dart';
import 'screens/add_form_screen.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  // Список покупок (основные данные приложения)
  List<Item> _items = [];

  // Контролируем текущий экран
  bool _isAdding = false;

  // Добавление новой позиции
  void _addItem(String title, String? note) {
    setState(() {
      final newItem = Item(
        title: title,
        note: note,
        createdAt: DateTime.now(),
      );
      _items.add(newItem);
      _isAdding = false; // возвращаемся на экран списка
    });
  }

  // Переключение состояния "куплено"
  // 🟢 обновлённая логика: купленные — вниз, некупленные — вверх
  void _toggleItem(String id) {
    setState(() {
      final index = _items.indexWhere((i) => i.id == id);
      if (index != -1) {
        final item = _items[index];
        final updated = item.copyWith(isBought: !item.isBought);

        // Удаляем старое положение
        _items.removeAt(index);

        if (updated.isBought) {
          // Перемещаем купленные в конец
          _items.add(updated);
        } else {
          // Возвращаем некупленные в начало
          _items.insert(0, updated);
        }
      }
    });
  }

  // Удаление позиции
  void _deleteItem(String id) {
    setState(() {
      _items.removeWhere((i) => i.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: _isAdding
          ? AddFormScreen(
        onSave: _addItem,
        onCancel: () => setState(() => _isAdding = false),
      )
          : ListScreen(
        items: _items,
        onAddPressed: () => setState(() => _isAdding = true),
        onToggle: _toggleItem,
        onDelete: _deleteItem,
      ),
    );
  }
}
