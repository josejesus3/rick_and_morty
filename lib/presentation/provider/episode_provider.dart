import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';

final episodeProvider =
    StateNotifierProvider<EpisodeNotifier, List<Episode>>((ref) {
  final getEpisodes = ref.watch(rickMortyRepositoriProvider).getEpisodes;
  return EpisodeNotifier(getEpisodes: getEpisodes);
});
typedef GetEpisodeCallback = Future<List<Episode>> Function(
    List<String> personaje);

class EpisodeNotifier extends StateNotifier<List<Episode>> {
  bool isLoading = false;
  final GetEpisodeCallback getEpisodes;
  EpisodeNotifier({required this.getEpisodes}) : super([]);

  Future<void> loadEpisode(List<String> personaje) async {
    if (isLoading) return;
    isLoading = true;
    final List<Episode> episodios = await getEpisodes(personaje);
    state = [...state, ...episodios];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
