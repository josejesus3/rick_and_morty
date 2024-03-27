import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/episode.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';

final episodesIdProvider =
    StateNotifierProvider<CharacterNotifier, Map<String, Episodes>>((ref) {
  final fetchMoreCharacter = ref.watch(rickMortyRepositoriProvider).getEpisode;
  return CharacterNotifier(getCharacter: fetchMoreCharacter);
});

typedef GetCharacterCallback = Future<Episodes> Function(String id);

class CharacterNotifier extends StateNotifier<Map<String, Episodes>> {
  final GetCharacterCallback getCharacter;
  CharacterNotifier({required this.getCharacter}) : super({});

  Future<void> loadEpisode(String id) async {
    if (state[id.toString()] != null) return;

    final character = await getCharacter(id);
    state = {...state, id.toString(): character};
  }
}
