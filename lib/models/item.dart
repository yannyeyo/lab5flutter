class Item {
  final String id;
  final String title;
  final String? note;
  final DateTime createdAt;
  final bool isBought;

  Item({
    required this.title,
    this.note,
    required this.createdAt,
    this.isBought = false,
  }) : id = DateTime.now().microsecondsSinceEpoch.toString();

  Item copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? createdAt,
    bool? isBought,
  }) {
    return Item(
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      isBought: isBought ?? this.isBought,
    );
  }
}
