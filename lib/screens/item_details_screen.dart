// lib/screens/item_details_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  const ItemDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final idx = app.items.indexWhere((e) => e.id == id);
    if (idx == -1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Детали'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Элемент не найден'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      );
    }
    final item = app.items[idx];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text(
              item.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text('Категория: ${item.category}'),
          ),
          const SizedBox(height: 8),
          if (item.note != null && item.note!.trim().isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(item.note!),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Куплено:'),
              const SizedBox(width: 12),
              Switch(
                value: item.isBought,
                onChanged: (_) => app.toggle(item.id),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: () {
              app.deleteById(item.id);
              context.pop();
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
