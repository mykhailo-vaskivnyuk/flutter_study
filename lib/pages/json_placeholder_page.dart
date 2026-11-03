import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/json_placeholder_view_model.dart';

class JsonPlaceholderPage extends StatefulWidget {
  const JsonPlaceholderPage({super.key});

  @override
  State<JsonPlaceholderPage> createState() => _JsonPlaceholderPageState();
}

class _JsonPlaceholderPageState extends State<JsonPlaceholderPage> {
  final JsonPlaceholderViewModel _viewModel = JsonPlaceholderViewModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ListenableBuilder(
            listenable: _viewModel,
            builder: (context, _) {
              return Text(_viewModel.album?.title ?? 'No album found');
            },
          ),
          ElevatedButton(
            onPressed: () {
              _viewModel.fetchAlbum();
            },
            child: Text('Fetch Album'),
          ),
        ],
      ),
    );
  }
}
