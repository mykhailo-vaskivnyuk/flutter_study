import 'package:flutter_app_first/wiki/article_widget.dart';
import 'package:flutter_app_first/wiki/summary.dart';
import 'package:material_ui/material_ui.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ArticleWidget(summary: summary),
          ElevatedButton(
            onPressed: nextArticleCallback,
            child: const Text('Next random article'),
          ),
        ],
      ),
    );
  }
}
