import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/datasources/rick_morty_datasources.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/mappers/rick_morty_mapper.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_characters.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_response.dart';

void main() {
  List<String> personaje = [
    "https://rickandmortyapi.com/api/episode/1",
    "https://rickandmortyapi.com/api/episode/2",
    "https://rickandmortyapi.com/api/episode/3",
    "https://rickandmortyapi.com/api/episode/4",
    "https://rickandmortyapi.com/api/episode/5",
    "https://rickandmortyapi.com/api/episode/6",
    "https://rickandmortyapi.com/api/episode/7",
    "https://rickandmortyapi.com/api/episode/8",
    "https://rickandmortyapi.com/api/episode/9",
    "https://rickandmortyapi.com/api/episode/10",
    "https://rickandmortyapi.com/api/episode/11",
    "https://rickandmortyapi.com/api/episode/12",
    "https://rickandmortyapi.com/api/episode/13",
    "https://rickandmortyapi.com/api/episode/14",
    "https://rickandmortyapi.com/api/episode/15",
    "https://rickandmortyapi.com/api/episode/16",
    "https://rickandmortyapi.com/api/episode/17",
    "https://rickandmortyapi.com/api/episode/18",
    "https://rickandmortyapi.com/api/episode/19",
    "https://rickandmortyapi.com/api/episode/20",
    "https://rickandmortyapi.com/api/episode/21",
    "https://rickandmortyapi.com/api/episode/22",
    "https://rickandmortyapi.com/api/episode/23",
    "https://rickandmortyapi.com/api/episode/24",
    "https://rickandmortyapi.com/api/episode/25",
    "https://rickandmortyapi.com/api/episode/26",
    "https://rickandmortyapi.com/api/episode/27",
    "https://rickandmortyapi.com/api/episode/28",
    "https://rickandmortyapi.com/api/episode/29",
    "https://rickandmortyapi.com/api/episode/30",
    "https://rickandmortyapi.com/api/episode/31",
    "https://rickandmortyapi.com/api/episode/32",
    "https://rickandmortyapi.com/api/episode/33",
    "https://rickandmortyapi.com/api/episode/34",
    "https://rickandmortyapi.com/api/episode/35",
    "https://rickandmortyapi.com/api/episode/36",
    "https://rickandmortyapi.com/api/episode/37",
    "https://rickandmortyapi.com/api/episode/38",
    "https://rickandmortyapi.com/api/episode/39",
    "https://rickandmortyapi.com/api/episode/40",
    "https://rickandmortyapi.com/api/episode/41",
    "https://rickandmortyapi.com/api/episode/42",
    "https://rickandmortyapi.com/api/episode/43",
    "https://rickandmortyapi.com/api/episode/44",
    "https://rickandmortyapi.com/api/episode/45",
    "https://rickandmortyapi.com/api/episode/50",
  ];
  List<String> episodes = [];
  for (var i = 0; i < personaje.length; i++) {
    final nuevo = personaje[i].toString().substring(40);
    episodes.add(nuevo);
  }
  print(episodes);
  RickMortyDB().getEpisodes(episodes);
}

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
