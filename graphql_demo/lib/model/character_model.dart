// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(Map<String, dynamic> str) =>
    CharacterModel.fromJson(str);

String CharacterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  CharacterModel({
    this.data,
  });

  Data? data;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        data:json["data"]==null? null: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.characters,
    this.location,
    this.episodesByIds,
  });

  Characters? characters;
  Location? location;
  List<Location>? episodesByIds;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        characters:json["characters"] == null
            ? null
            :  Characters.fromJson(json["characters"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        episodesByIds: json["episodesByIds"] == null
            ? []
            : List<Location>.from(
                json["episodesByIds"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "characters": characters?.toJson(),
        "location": location?.toJson(),
        "episodesByIds":
            List<dynamic>.from(episodesByIds!.map((x) => x.toJson())),
      };
}

class Characters {
  Characters({
    this.info,
    this.results,
  });

  Info? info;
  List<Result>? results;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        info: Info.fromJson(json["info"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    this.count = 0,
    this.pages = 0,
  });

  int count = 0;
  int pages = 0;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
      };
}

class Result {
  Result({
    this.name = "",
    this.id = "",
    this.image = "",
    this.gender,
    this.status,
    this.species,
    this.type,
    this.created,
  });

  String name = "";
  String id = "";
  String image = "";
  Gender? gender;
  Status? status;
  Species? species;
  Type? type;
  DateTime? created;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        id: json["id"],
        image: json["image"],
        gender: genderValues.map[json["gender"]],
        status: statusValues.map[json["status"]],
        species: speciesValues.map[json["species"]],
        type: typeValues.map[json["type"]],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image,
        "gender": genderValues.reverse?[gender],
        "status": statusValues.reverse?[status],
        "species": speciesValues.reverse?[species],
        "type": typeValues.reverse?[type],
        "created": created?.toIso8601String(),
      };
}

enum Gender { MALE }

final genderValues = EnumValues({"Male": Gender.MALE});

enum Species { HUMAN, ALIEN, HUMANOID, CRONENBERG }

final speciesValues = EnumValues({
  "Alien": Species.ALIEN,
  "Cronenberg": Species.CRONENBERG,
  "Human": Species.HUMAN,
  "Humanoid": Species.HUMANOID
});

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

enum Type { EMPTY, HUMAN_WITH_ANTENNAE, FISH_PERSON, ROBOT }

final typeValues = EnumValues({
  "": Type.EMPTY,
  "Fish-Person": Type.FISH_PERSON,
  "Human with antennae": Type.HUMAN_WITH_ANTENNAE,
  "Robot": Type.ROBOT
});

class Location {
  Location({
    this.id = "",
  });

  String id = "";

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map, [this.reverseMap]);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
