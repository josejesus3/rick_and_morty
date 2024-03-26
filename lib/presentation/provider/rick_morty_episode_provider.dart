import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty_episode.dart';
import 'package:rick_and_morty/presentation/provider/rick_morty_repositori.dart';

final rickMortyEpisodeProvider =
    StateNotifierProvider<RickMortyNotifier, List<RickMortyEpisode>>((ref) {
  final getRickMorty = ref.watch(rickMortyRepositoriProvider).getEpisode;
  return RickMortyNotifier(getRickMorty: getRickMorty);
});

typedef RickMortyCallback = Future<List<RickMortyEpisode>> Function(
    List<int> id);

class RickMortyNotifier extends StateNotifier<List<RickMortyEpisode>> {
  int currentPage = 0;
  bool isLoading = false;
  RickMortyCallback getRickMorty;

  RickMortyNotifier({required this.getRickMorty}) : super([]);

  Future<void> loadNextPage(List<int> id) async {
    if (id.isEmpty || isLoading)
      return; // Agrega verificación si id está vacío o si ya se está cargando

    try {
      isLoading = true; // Marca que se está cargando

      final characters = await getRickMorty(id);
      state = [
        ...state,
        ...characters
      ]; // Agrega los nuevos personajes a la lista existente

      isLoading = false; // Marca que la carga ha terminado
    } catch (error) {
      // Maneja errores aquí
    }
  }
}
