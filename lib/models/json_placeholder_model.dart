import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class JsonPlaceholderModel {
  Future<Album> fetchAlbum() async {
    final albumId = Random().nextInt(100) + 1;
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/albums/$albumId',
    );
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
