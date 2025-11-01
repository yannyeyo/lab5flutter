import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../models/items_list.dart';
import '../app_state.dart';
import 'gallery_screen.dart';
import 'add_form_screen.dart';

class ListScreen extends StatelessWidget {
  final bool routerMode;
  const ListScreen({super.key, this.routerMode = false});

  // конструктор, чтобы понимать что экран открыт по маршрутам
  const ListScreen.routerMode({super.key}) : routerMode = true;

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final items = app.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        actions: [
          // Галерея (маршрутизированная вертикальная)
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => context.push('/gallery'),
          ),
          // Статистика (маршрутизированная вертикальная)
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => context.push('/stats'),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Страничная вертикальная навигация: push на форму
          FloatingActionButton.extended(
            heroTag: 'fab1',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddFormScreen()),
            ),
            label: const Text('Добавить (push)'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          // Маршрутизированная вертикальная навигация: push на /add
          FloatingActionButton.extended(
            heroTag: 'fab2',
            onPressed: () => context.push('/add'),
            label: const Text('Добавить (route)'),
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Список пуст.'))
          : ItemsList(
        items: items,
        onToggle: app.toggle,
        onDelete: app.deleteById,
      ),
    );
  }
}
