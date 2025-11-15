import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/items_list.dart';
import '../bloc/shopping_cubit.dart';
import '../bloc/shopping_state.dart';
import '../navigation/routes.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});
  const ListScreen.routerMode({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select(
          (ShoppingCubit c) => c.state.items,
    );
    final cubit = context.read<ShoppingCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => context.push(Routes.gallery),
          ),
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => context.push(Routes.stats),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.add),
        label: const Text('Добавить'),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Список пуст.'));
          }
          return ItemsList(
            items: state.items,
            onToggle: cubit.toggle,
            onDelete: cubit.deleteById,
          );
        },
      ),
    );
  }
}
