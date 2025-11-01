import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';
import 'app_state.dart';
import 'models/item.dart';
import 'screens/list_screen.dart';
import 'screens/add_form_screen.dart';

void main() => runApp(const ShoppingApp());

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});
  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  late final AppState state;

  @override
  void initState() {
    super.initState();
    state = AppState(<Item>[]);
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: state,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Shopping',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
        routerConfig: appRouter,
      ),
    );
  }
}
