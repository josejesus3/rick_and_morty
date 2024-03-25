import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/datasources/rick_morty_datasources.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/mappers/rick_morty_mapper.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_characters.dart';

class RickMortyDB extends RickMortyDatasources {
  final dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  List<RickMorty> jsonToRickMorty(Map<String, dynamic> json) {
    final rickMortyCharacters = RickMortyCharacters.fromJson(json);
    final List<RickMorty> rickMorty = rickMortyCharacters.results
        .map((rickMorty) => RickMortyMapper.rickMortyDBToEntity(rickMorty))
        .toList();

    return rickMorty;
  }

  @override
  Future<List<RickMorty>> getCharacter({int page=1}) async {
    final response =
        await dio.get('/character', queryParameters: {'page': page});
    return jsonToRickMorty(response.data);
  }
}
