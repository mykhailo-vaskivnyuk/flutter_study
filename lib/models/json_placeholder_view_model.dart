import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/json_placeholder_model.dart';

class JsonPlaceholderViewModel extends ChangeNotifier {
  final JsonPlaceholderModel _model = JsonPlaceholderModel();
  Album? album;

  Future<void> fetchAlbum() async {
    album = await _model.fetchAlbum();
    notifyListeners();
  }
}