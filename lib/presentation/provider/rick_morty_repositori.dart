import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/infrastructure/datasources/rick_mortydb.dart';
import 'package:rick_and_morty/infrastructure/repositories/rick_morty_imp.dart';

final rickMortyRepositoriProvider = Provider(
  (ref) => RickMortyImp(datasources: RickMortyDB()),
);

final rickMortyBotton = StateProvider((ref) => 0);
