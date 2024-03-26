import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty_episode.dart';
import 'package:rick_and_morty/presentation/provider/rick_morty_repositori.dart';

final rickMortyProvider =
    StateNotifierProvider<RickMortyNotifier, List<RickMortyEpisode>>((ref) {
  final getRickMorty = ref.watch(rickMortyRepositoriProvider).getEpisode;
  return RickMortyNotifier(getRickMorty: getRickMorty);
});
final rickMortyEpisodeProvider =
    StateNotifierProvider<RickMortyNotifier, List<RickMortyEpisode>>((ref) {
  final getRickMorty = ref.watch(rickMortyRepositoriProvider).getEpisode;
  return RickMortyNotifier(getRickMorty: getRickMorty);
});

typedef RickMortyCallback = Future<List<RickMortyEpisode>> Function({int page});

class RickMortyNotifier extends StateNotifier<List<RickMortyEpisode>> {
  int currentPage = 0;
  bool isloading = false;
  RickMortyCallback getRickMorty;
  RickMortyNotifier({required this.getRickMorty}) : super([]);

  Future<void> loadNextPage() async {
    if (isloading) return;
    isloading = true;
    currentPage++;
    final List<RickMortyEpisode> rickMorty =
        await getRickMorty(page: currentPage);
    state = [...state, ...rickMorty];
    await Future.delayed(const Duration(milliseconds: 300));
    isloading = false;
  }
}
