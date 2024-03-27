import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/entities/episode.dart';

abstract class RickMortyDatasources {
  Future<List<RickMorty>> getCharacter({int page = 1});
  Future<RickMorty> getCharacterId(String id);
  Future<Episodes> getEpisode(String id);
}
