import 'dart:io';

import 'package:flutter_app_first/wiki/article_model.dart';
import 'package:flutter_app_first/wiki/summary.dart';
import 'package:material_ui/material_ui.dart';

class ArticleViewModel extends ChangeNotifier {
  ArticleViewModel(this.model) {
    fetchArticle();
  }

  final ArticleModel model;
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  Future<void> fetchArticle() async {
    isLoading = true;
    error = null;
    summary = null;
    notifyListeners();

    try {
      summary = await model.getRandomArticleSummary();
      print('Article loaded: ${summary!.titles.normalized}'); // Temporary
    } on HttpException catch (e) {
      error = e;
    }

    isLoading = false;
    notifyListeners();
  }
}
