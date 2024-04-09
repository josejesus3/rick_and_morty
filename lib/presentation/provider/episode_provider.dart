import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';
import 'package:rick_and_morty/infrastructure/repositories/rick_morty_imp.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';

final episodeProvider =
    StateNotifierProvider<EpisodeNotifier, List<Episode>>((ref) {
  final getEpisodes = ref.watch(rickMortyRepositoriProvider).getEpisodes;
  final getCharacter = ref.watch(rickMortyRepositoriProvider);
  return EpisodeNotifier(
      getEpisodes: getEpisodes, characterInfoProvider: getCharacter);
});
typedef GetEpisodeCallback = Future<List<Episode>> Function(
    List<String> personaje);

class EpisodeNotifier extends StateNotifier<List<Episode>> {
  bool isLoading = false;
  final GetEpisodeCallback getEpisodes;
  final RickMortyImp
      characterInfoProvider; // Agrega referencia a characterInfoProvider
  EpisodeNotifier(
      {required this.getEpisodes, required this.characterInfoProvider})
      : super([]);

  Future<void> loadEpisode(String characterId) async {
    if (isLoading) return;
    isLoading = true;

    // Obtener información del personaje usando characterInfoProvider
    final RickMorty character =
        await characterInfoProvider.getCharacterId(characterId);
    await  Future.delayed(const Duration(milliseconds: 300));
    // Obtener los episodios asociados con el personaje
    final List<Episode> allEpisodes = await getEpisodes(character.episode);

    // Asignar los episodios filtrados al estado
    state = [...state, ...allEpisodes];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
