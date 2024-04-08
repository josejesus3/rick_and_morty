import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/presentation/screen/screen.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
    path: '/home/:page',
    builder: (context, state) {
      return const HomeScreen();
    },
  ),
  /*GoRoute(
    path: '/character/:id',
    builder: (context, state) {
      final characterId = state.pathParameters['id']??'0';
      return CharacterScreen(
        characterId: characterId,
      );
    },
  )*/
]);
