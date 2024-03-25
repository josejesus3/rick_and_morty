import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/presentation/provider/rick_morty_repositori.dart';

final rickMortyProvider=StateNotifierProvider<RickMortyNotifier,List<RickMorty>>((ref) {
   final getRickMorty = ref.watch(rickMortyRepositoriProvider).getCharacter;
   return RickMortyNotifier(getRickMorty: getRickMorty);

} );

typedef RickMortyCallback = Future<List<RickMorty>> Function({int page});

class RickMortyNotifier extends StateNotifier<List<RickMorty>> {
  int currentPage = 0;
  bool isloading = false;
  RickMortyCallback getRickMorty;
  RickMortyNotifier({required this.getRickMorty}) : super([]);

  Future<void> loadNextPage() async {
    if (isloading) return;
    isloading = true;
    currentPage++;
    final List<RickMorty> rickMorty = await getRickMorty(page: currentPage);
    state = [...state, ...rickMorty];
    await Future.delayed(const Duration(milliseconds: 300));
    isloading = false;
  }
}
