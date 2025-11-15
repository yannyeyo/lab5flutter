import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/item.dart';
import 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(const ShoppingState());

  void addItem(Item it) {
    // создаём новый список, добавляем элемент и эмитим новое состояние
    final next = List<Item>.from(state.items)..add(it);
    emit(state.copyWith(items: next));
  }

  void deleteById(String id) {
    final next = state.items.where((e) => e.id != id).toList();
    emit(state.copyWith(items: next));
  }

  void toggle(String id) {
    final next = state.items.map((e) {
      if (e.id == id) {
        return e.copyWith(isBought: !e.isBought);
      }
      return e;
    }).toList();
    emit(state.copyWith(items: next));
  }

  /// Возвращает элемент по id или null, если не найден.
  Item? itemById(String id) {
    try {
      return state.items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
