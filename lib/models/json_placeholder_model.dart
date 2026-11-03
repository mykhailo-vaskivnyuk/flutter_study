
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class JsonPlaceholderModel {
  Future<Album> fetchAlbum() async {
    final albumId = Random().nextInt(100) + 1;
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/albums/$albumId',
    );
    final response = await http.get(url);

    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
