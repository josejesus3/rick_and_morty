
import 'package:rick_and_morty/infrastructure/models/rick_morty_results.dart';

class Episode {
    final Info info;
    final List<Result> results;

    Episode({
        required this.info,
        required this.results,
    });

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        info: Info.fromJson(json["info"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
        next: json["next"]??'',
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

