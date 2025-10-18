import 'package:flutter/material.dart';
import '../models/item.dart';

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
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isBought ? TextDecoration.lineThrough : null,
          color: item.isBought ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: item.note != null && item.note!.isNotEmpty
          ? Text(item.note!)
          : null,
      trailing: Checkbox(
        value: item.isBought,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}
