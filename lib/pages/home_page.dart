import 'package:flutter/material.dart';
import 'package:flutter_app_first/layouts/layout.dart';
import 'package:flutter_app_first/layouts/layout_page.dart';
import 'package:flutter_app_first/pages/counter_page.dart';
import 'package:flutter_app_first/pages/json_placeholder_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayoutPageWidget(
                    title: 'Counter Page',
                    page: CounterPage(),
                  ),
                ),
              );
            },
            child: Text('Go to Counter Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LayoutPageWidget(title: 'Json Placeholder Page', page: JsonPlaceholderPage())),
              );
            },
            child: Text('Go to Json Placeholder Page'),
          ),
        ],
      ),
    );
  }
}
