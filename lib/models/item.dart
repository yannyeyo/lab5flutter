// lib/models/item.dart
class Item {
  final String id;
  final String title;
  final String? note;
  final DateTime createdAt;
  final bool isBought;
  final String category; // категория (одна из kCategories)

  Item({
    required this.title,
    this.note,
    required this.createdAt,
    this.isBought = false,
    required this.category,
  }) : id = DateTime.now().microsecondsSinceEpoch.toString();

  Item copyWith({
    String? title,
    String? note,
    DateTime? createdAt,
    bool? isBought,
    String? category,
  }) {
    return Item(
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      isBought: isBought ?? this.isBought,
      category: category ?? this.category,
    );
  }
}
