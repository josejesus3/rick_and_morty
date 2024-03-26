import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/entities/rick_morty_episode.dart';

abstract class RickMortyRepositories {
  Future<List<RickMorty>> getCharacter({int page = 1});
  Future<List<RickMortyEpisode>> getEpisode(List<int> id);

  Future<RickMorty> getCharacterId(String id);
}
