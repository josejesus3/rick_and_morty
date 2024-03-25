import 'package:rick_and_morty/infrastructure/models/rick_morty_response.dart';

class RickMortyCharacters {
  final Info info;
  final List<RickMortyResponse> results;

  RickMortyCharacters({
    required this.info,
    required this.results,
  });

  factory RickMortyCharacters.fromJson(Map<String, dynamic> json) =>
      RickMortyCharacters(
        info: Info.fromJson(json["info"]),
        results: List<RickMortyResponse>.from(json["results"].map(
            (x) => RickMortyResponse.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  final int count;
  final int pages;
  final String next;
  final dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
