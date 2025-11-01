// lib/models/item.dart
class Item {
  final String id;
  final String title;
  final String? note;
  final DateTime createdAt;
  final bool isBought;
  final String category; // категория (одна из kCategories)

  Item({
    String? id,                             // ← id можно передать, иначе сгенерим
    required this.title,
    this.note,
    required this.createdAt,
    this.isBought = false,
    required this.category,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  Item copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? createdAt,
    bool? isBought,
    String? category,
  }) {
    return Item(
      id: id ?? this.id,                    // ← Сохраняем прежний id!
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      isBought: isBought ?? this.isBought,
      category: category ?? this.category,
    );
  }

  // (опционально) сериализация — пригодится позже
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'note': note,
    'createdAt': createdAt.toIso8601String(),
    'isBought': isBought,
    'category': category,
  };

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'] as String?,
    title: json['title'] as String,
    note: json['note'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    isBought: json['isBought'] as bool? ?? false,
    category: json['category'] as String,
  );

  @override
  bool operator ==(Object other) => other is Item && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
