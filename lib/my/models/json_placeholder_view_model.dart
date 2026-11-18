import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/json_placeholder_model.dart';
import 'package:http/http.dart' as http;

class JsonPlaceholderViewModel extends ChangeNotifier {
  final JsonPlaceholderModel _model = JsonPlaceholderModel(
    client: http.Client(),
  );
  Album? album;

  Future<Album> fetchAlbum() async {
    album = await _model.fetchAlbum();
    notifyListeners();
    return album!;
  }
}
