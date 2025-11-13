import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/items_list.dart';
import '../app_state.dart';
import '../navigation/routes.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  const ListScreen.routerMode({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final items = store.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => context.push(Routes.gallery),
          ),
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => context.push(Routes.stats),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.add),
        label: const Text('Добавить'),
        icon: const Icon(Icons.add),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Список пуст.'))
          : ItemsList(
        items: items,
        onToggle: store.toggle,
        onDelete: store.deleteById,
      ),
    );
  }
}
