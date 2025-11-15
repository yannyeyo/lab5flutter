import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/shopping_cubit.dart';
import '../bloc/shopping_state.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  const ItemDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShoppingCubit>();
    final item = cubit.itemById(id);
    if (item == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Детали'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: Text('Элемент не найден')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          final current = state.items.firstWhere((e) => e.id == id, orElse: () => item);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                title: Text(
                  current.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: Text('Категория: ${current.category}'),
              ),
              const SizedBox(height: 8),
              if (current.note != null && current.note!.trim().isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(current.note!),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Куплено:'),
                  const SizedBox(width: 12),
                  Switch(
                    value: current.isBought,
                    onChanged: (_) => context.read<ShoppingCubit>().toggle(current.id),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                onPressed: () {
                  context.read<ShoppingCubit>().deleteById(current.id);
                  context.pop();
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Удалить'),
              ),
            ],
          );
        },
      ),
    );
  }
}
