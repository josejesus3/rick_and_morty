import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/models/rick_morty_response.dart';

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

  
}
