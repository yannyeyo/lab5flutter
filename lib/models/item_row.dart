import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/item.dart';
import '../models/category_icons.dart'; // categoryIcon()

class ItemRow extends StatelessWidget {
  final Item item;
  final VoidCallback onToggle;

  const ItemRow({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: categoryIcon(item.category),
        width: 32,
        height: 32,
        fit: BoxFit.contain,
        placeholder: (c, u) => const SizedBox(
          width: 32, height: 32,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (c, u, e) => const Icon(Icons.error),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isBought ? TextDecoration.lineThrough : null,
          color: item.isBought ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Text(
        '${item.category}${item.note != null && item.note!.isNotEmpty ? " — ${item.note}" : ""}',
      ),
      trailing: Checkbox(
        value: item.isBought,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}
