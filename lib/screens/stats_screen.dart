import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../di/locator.dart';
import '../services/item_service.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final svc = di<ItemService>();
    final total = svc.items.length;
    final done = svc.items.where((e) => e.isBought).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        leading: IconButton(
          tooltip: 'Назад',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Text('Всего: $total\nГотово: $done'),
      ),
    );
  }
}
