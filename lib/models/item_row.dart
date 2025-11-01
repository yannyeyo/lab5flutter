// lib/models/item_row.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'item.dart';
import 'category_icons.dart'; // тут лежат kCategories, kCategoryIconUrl и categoryIcon()

class ItemRow extends StatelessWidget {
  final Item item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ItemRow({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.network(
            categoryIcon(item.category),
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            // если картинка не загрузилась — показываем стандартную иконку
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.shopping_basket_outlined),
          ),
        ),
      ),

      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isBought ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: (item.note != null && item.note!.trim().isNotEmpty)
          ? Text(item.note!)
          : null,

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: item.isBought,
            onChanged: (_) => onToggle(),
          ),
          IconButton(
            tooltip: 'Детали',
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.push('/details/${item.id}'),
          ),
          IconButton(
            tooltip: 'Удалить',
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
