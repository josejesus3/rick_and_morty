import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';

final characterInfoProvider =
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
