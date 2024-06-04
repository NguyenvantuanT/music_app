import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:music_app/models/song_model.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  String url = 'https://thantrieu.com/resources/braniumapis/songs.json';

  @override
  Future<List<Song>?> loadData() async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      Map<String, dynamic> json = jsonDecode(bodyContent);
      List<dynamic> body = json['songs'];
      return body.map((json) => Song.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    Map<String,dynamic>  json = jsonDecode(response);
    List<dynamic> body = json['songs'];
    return body.map((json) => Song.fromJson(json)).toList();
  }
}
