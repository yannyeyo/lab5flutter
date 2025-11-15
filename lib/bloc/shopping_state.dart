import '../models/item.dart';

class ShoppingState {
  final List<Item> items;

  const ShoppingState({this.items = const []});

  ShoppingState copyWith({List<Item>? items}) =>
      ShoppingState(items: items ?? this.items);
}
