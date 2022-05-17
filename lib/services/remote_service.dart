import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_api/models/coinlist.dart';
import 'package:flutter/services.dart' show rootBundle;

class RemoteService {
  static getCoins() async {
    final response =
        await http.get(Uri.parse("http://api.coincap.io/v2/assets"));
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body);

      ///instead of returning posts i returned posts['data']
      /// remember it is a map, and what we need from the api is ['data']
      /// this is without using a model class
      return posts['data'];
    } else {
      throw Exception('Failed to load. OKAY ?');
    }
  }
}
