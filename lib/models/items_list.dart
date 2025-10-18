import 'package:flutter/material.dart';
import '../../models/item.dart';
import 'item_row.dart';

class ItemsList extends StatelessWidget {
  final List<Item> items;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const ItemsList({
    super.key,
    required this.items,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item.id),
          onDismissed: (_) => onDelete(item.id),
          background: Container(color: Colors.redAccent),
          child: ItemRow(
            item: item,
            onToggle: () => onToggle(item.id),
          ),
        );
      },
    );
  }
}
