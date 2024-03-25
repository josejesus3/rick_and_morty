
import 'package:rick_and_morty/domain/datasources/rick_morty_datasources.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/domain/repositories/rick_morty_repositories.dart';

class RickMortyImp extends RickMortyRepositories{
  final RickMortyDatasources datasources;

  RickMortyImp({required this.datasources});
  
  @override
  Future<List<RickMorty>> getCharacter({int page=1}) {
    return datasources.getCharacter(page: page);
   
  }

}