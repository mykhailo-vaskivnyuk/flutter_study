import 'package:flutter_app_first/wiki/article_model.dart';
import 'package:flutter_app_first/wiki/article_page.dart';
import 'package:flutter_app_first/wiki/article_view_model.dart';
import 'package:material_ui/material_ui.dart';

class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return switch ((
            viewModel.isLoading,
            viewModel.summary,
            viewModel.error,
          )) {
            (true, _, _) => const CircularProgressIndicator(),
            (_, _, final Exception e) => Text('Error: $e'),
            (_, final summary?, _) => ArticlePage(
              summary: summary,
              nextArticleCallback: viewModel.fetchArticle,
            ),
            _ => const Text('Something went wrong!'),
          };
        },
      ),
    );
  }
}
