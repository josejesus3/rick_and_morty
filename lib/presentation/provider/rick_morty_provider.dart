import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/presentation/provider/rick_morty_repositori.dart';

final rickMortyProvider =
    StateNotifierProvider<RickMortyNotifier, List<RickMorty>>((ref) {
  final getRickMorty = ref.watch(rickMortyRepositoriProvider).getCharacter;
  return RickMortyNotifier(getRickMorty: getRickMorty);
});

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

final characterIdProvider =
    StateNotifierProvider<CharacterNotifier, Map<String, RickMorty>>((ref) {
  final fetchMoreCharacter =
      ref.watch(rickMortyRepositoriProvider).getCharacterId;
  return CharacterNotifier(getCharacter: fetchMoreCharacter);
});

typedef GetCharacterCallback = Future<RickMorty> Function(String id);

class CharacterNotifier extends StateNotifier<Map<String, RickMorty>> {
  final GetCharacterCallback getCharacter;
  CharacterNotifier({required this.getCharacter}) : super({});

  Future<void> loadChart(String id) async {
    if (state[id.toString()] != null) return;

    final character = await getCharacter(id);
    state = {...state, id.toString(): character};
  }
}
