import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/presentation/screen/character_screen.dart';
import 'package:rick_and_morty/presentation/screen/screen.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
    path: '/home/:page',
    builder: (context, state) {
      final int pageIndex = int.parse(state.pathParameters['page'] ?? '0');
      return HomeScreen(
        pageIndex: pageIndex,
      );
    },
  ),
  GoRoute(
    path: '/character/:id',
    builder: (context, state) {
      final characterId = state.pathParameters['id']??'0';
      return CharacterScreen(
        characterId: characterId,
      );
    },
  )
]);
