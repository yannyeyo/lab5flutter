import 'package:flutter/material.dart';
import 'models/item.dart';

class AppState extends ChangeNotifier {
  final List<Item> items;
  AppState(this.items);

  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void toggle(String id) {
    final i = items.indexWhere((e) => e.id == id);
    if (i != -1) {
      items[i] = items[i].copyWith(isBought: !items[i].isBought);
      notifyListeners();
    }
  }

  void deleteById(String id) {
    items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required super.notifier, required super.child});
  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
