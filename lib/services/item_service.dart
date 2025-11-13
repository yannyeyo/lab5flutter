import 'package:flutter/foundation.dart';
import '../models/item.dart';

class ItemService extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  void add(Item it) {
    _items.add(it);
    notifyListeners();
  }

  void deleteById(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void toggle(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i == -1) return;
    final old = _items[i];
    _items[i] = old.copyWith(isBought: !old.isBought);
    notifyListeners();
  }

  Item? byId(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    return i == -1 ? null : _items[i];
  }
}
