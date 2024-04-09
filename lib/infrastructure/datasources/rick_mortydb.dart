import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/datasources/rick_morty_datasources.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/mappers/rick_morty_mapper.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_characters.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_response.dart';

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
  Future<List<RickMorty>> getCharacter({int page = 1}) async {
    final response =
        await dio.get('/character', queryParameters: {'page': page});
    return jsonToRickMorty(response.data);
  }

  @override
  Future<RickMorty> getCharacterId(String id) async {
    final response = await dio.get('/character/$id');
    if (response.statusCode != 200)
      throw Exception('Character with id:$id not found');
    final characterDB = RickMortyResponse.fromJson(response.data);
    final RickMorty movieDetails =
        RickMortyMapper.rickMortyDBToEntity(characterDB);
    return movieDetails;
  }

  @override
  Future<List<Episode>> getEpisodes(List<String> personaje) async {
    final dio = Dio();
    List<Episode> episodes = [];

    for (var element in personaje) {
      final response = await dio.get(
          'https://rickandmortyapi.com/api/episode/${element.substring(40)}');
      if (response.statusCode == 200) {
        final Episode episode = Episode.fromJson(response.data);
        episodes.add(episode);
      } else {
        print('error');
      }
    }

    return episodes;
  }
}
