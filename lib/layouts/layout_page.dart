import 'package:flutter/material.dart';

class LayoutPageWidget extends StatelessWidget {
  const LayoutPageWidget({super.key, required this.title, required this.page});

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: page,
    );
  }
}
