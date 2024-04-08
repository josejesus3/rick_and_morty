import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';

abstract class RickMortyRepositories {
  Future<List<RickMorty>> getCharacter({int page = 1});
  Future<RickMorty> getCharacterId(String id);
  Future<List<Episode>> getEpisodes(List<String> personaje);
}
