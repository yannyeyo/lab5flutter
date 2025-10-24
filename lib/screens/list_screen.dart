import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/items_list.dart';
import 'gallery_screen.dart'; // импорт нового экрана

class ListScreen extends StatelessWidget {
  final List<Item> items;
  final VoidCallback onAddPressed;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const ListScreen({
    super.key,
    required this.items,
    required this.onAddPressed,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        actions: [
          // кнопка перехода на экран галереи
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GalleryScreen()),
              );
            },
          ),
          IconButton(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
        child: Text(
          'Список пуст.\nДобавьте покупки через “+”',
          textAlign: TextAlign.center,
        ),
      )
          : ItemsList(
        items: items,
        onToggle: onToggle,
        onDelete: onDelete,
      ),
    );
  }
}
