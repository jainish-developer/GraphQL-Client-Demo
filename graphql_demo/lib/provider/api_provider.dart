import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_demo/model/character_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class CharacterAPIProvider with ChangeNotifier {
  // List<Characters> apiData = [];
  CharacterModel? characters;
  int pages = 0;
  Future<void> fetchData() async {
    try {
      
      Response response =
          await post(Uri.parse("https://rickandmortyapi.com/graphql"), body: {
        "query":
            "query {\n  characters(page: ${pages}) {\n    info {\n      count\n      pages\n    }\n    results {\n      name\n      id\n      image\n      gender\n      status\n      species\n      type\n      created\n    }\n  }\n  location(id: 1) {\n    id\n  }\n  episodesByIds(ids: [1, 2]) {\n    id\n  }\n}\n"
      });

      print(response.body);
      characters = characterModelFromJson(jsonDecode(response.body));
      print(characters?.toJson());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
