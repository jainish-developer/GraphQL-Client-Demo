import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_demo/model/character_model.dart';
import 'package:http/http.dart';
import 'package:kd_api_call/kd_api_call.dart';

class CharacterAPIProvider with ChangeNotifier {
  CharacterModel? characters;

  Future<void> fetchData(int pages) async {
    try {
      Uri uri = Uri.parse("https://rickandmortyapi.com/graphql");

      await ApiCall.checkConnectivity();

      Response response = await post(uri, body: {
        "query":
            "query {\n  characters(page: $pages) {\n    info {\n      count\n      pages\n    }\n    results {\n      name\n      id\n      image\n      gender\n      status\n      species\n      type\n      created\n    }\n  }\n  location(id: 1) {\n    id\n  }\n  episodesByIds(ids: [1, 2]) {\n    id\n  }\n}\n"
      });

      if (response.statusCode == 200) {
        CharacterModel _characters =
            characterModelFromJson(jsonDecode(response.body));
        if (characters == null) {
          characters = _characters;
        } else {
          List<Result> _result = _characters.data?.characters?.results ?? [];
          Info? _info = _characters.data?.characters?.info;
          characters?.data?.characters?.info = _info;
          characters?.data?.characters?.results?.addAll(_result);
        }
      }

      notifyListeners();
    } on AppException catch (e) {
      throw e.message ?? "Something went wrong!";
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
