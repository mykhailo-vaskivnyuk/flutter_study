import 'package:flutter_app_first/wiki/article_view.dart';
import 'package:material_ui/material_ui.dart';

class WikiApp extends StatelessWidget {
  const WikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ArticleView());
  }
}
