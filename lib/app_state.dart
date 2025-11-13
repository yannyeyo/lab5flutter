import 'package:flutter/widgets.dart';
import 'di/locator.dart';
import 'services/item_service.dart';

class AppScope extends InheritedNotifier<ItemService> {
  AppScope({super.key, required Widget child})
      : super(notifier: di<ItemService>(), child: child);

  static ItemService of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in widget tree');
    return scope!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<ItemService> oldWidget) {
    return oldWidget.notifier != notifier;
  }
}
