import 'package:flutter/material.dart';
import '../app_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final total = app.items.length;
    final done = app.items.where((e) => e.isBought).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Center(
        child: Text('Всего: $total\nГотово: $done'),
      ),
    );
  }
}
