// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/list_screen.dart';
import 'screens/add_form_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/item_details_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (ctx, st) => const ListScreen.routerMode(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (ctx, st) => const AddFormScreen.routerMode(),
        ),
        GoRoute(
          path: 'gallery',
          builder: (ctx, st) => const GalleryScreen(),
        ),
        GoRoute(
          path: 'stats',
          builder: (ctx, st) => const StatsScreen(),
        ),
        GoRoute(
          path: 'details/:id',
          builder: (ctx, st) =>
              ItemDetailsScreen(id: st.pathParameters['id']!),
        ),
      ],
    ),
  ],
);
