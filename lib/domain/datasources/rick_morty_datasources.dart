import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/entities/rick_morty_episode.dart';

abstract class RickMortyDatasources {
  Future<List<RickMorty>> getCharacter({int page = 1});
  Future<List<RickMortyEpisode>> getEpisode({int page = 1});

  Future<RickMorty> getCharacterId(String id);
}
