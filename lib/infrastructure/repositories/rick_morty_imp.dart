import 'package:rick_and_morty/domain/datasources/rick_morty_datasources.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/repositories/rick_morty_repositories.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';

class RickMortyImp extends RickMortyRepositories {
  final RickMortyDatasources datasources;

  RickMortyImp({required this.datasources});

  @override
  Future<List<RickMorty>> getCharacter({int page = 1}) {
    return datasources.getCharacter(page: page);
  }

  @override
  Future<RickMorty> getCharacterId(String id) {
    return datasources.getCharacterId(id);
  }

  @override
  Future<List<Episode>> getEpisodes(List<String> personaje) {
    return datasources.getEpisodes(personaje);
  }
}
