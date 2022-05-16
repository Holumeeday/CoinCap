import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_api/models/coinlist.dart';
import 'package:flutter/services.dart' show rootBundle;

class RemoteService {


static getCoins()async{
  final response = await http.get(Uri.parse("http://api.coincap.io/v2/assets"));
  if (response.statusCode == 200){
    final posts = jsonDecode(response.body);
    print(posts['data'][1]);
    return posts;
  }else {
  throw Exception('Failed to load. OKAY ?');
  }
}


}