import 'package:rick_and_morty/domain/entities/rick_morty.dart';

abstract class RickMortyRepositories {
  Future<List<RickMorty>> getCharacter({int page = 1});
  Future<RickMorty> getCharacterId(String id);
}
