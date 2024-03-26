import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/entities/rick_morty_episode.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_response.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_results.dart';

class RickMortyMapper {
  static RickMorty rickMortyDBToEntity(RickMortyResponse rickMorty) =>
      RickMorty(
          id: rickMorty.id,
          name: rickMorty.name,
          status: rickMorty.status,
          species: rickMorty.species,
          type: rickMorty.type,
          gender: rickMorty.gender,
          origin: rickMorty.origin,
          location: rickMorty.location,
          image: rickMorty.image,
          episode: rickMorty.episode,
          url: rickMorty.url,
          created: rickMorty.created);

  static RickMortyEpisode rickMortyDBToEpisode(Result rickMorty) =>
      RickMortyEpisode(
          id: rickMorty.id,
          name: rickMorty.name,
          airDate: rickMorty.airDate,
          episode: rickMorty.episode,
          characters: rickMorty.characters,
          url: rickMorty.url,
          created: rickMorty.created);
}
