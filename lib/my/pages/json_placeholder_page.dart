import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/models/json_placeholder_model.dart';
import 'package:flutter_app_first/my/models/json_placeholder_view_model.dart';

class JsonPlaceholderPage extends StatefulWidget {
  const JsonPlaceholderPage({super.key});

  @override
  State<JsonPlaceholderPage> createState() => _JsonPlaceholderPageState();
}

class _JsonPlaceholderPageState extends State<JsonPlaceholderPage> {
  final JsonPlaceholderViewModel _viewModel = JsonPlaceholderViewModel();

  Future<Album>? _futureAlbum;

  @override
  initState() {
    super.initState();
    _futureAlbum = _viewModel.fetchAlbum();
  }

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
          FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              return Text(snapshot.data?.title ?? 'No album found');
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = _viewModel.fetchAlbum();
              });
            },
            child: Text('Fetch Album'),
          ),
        ],
      ),
    );
  }
}
