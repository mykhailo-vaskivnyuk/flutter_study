import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/pages/home_page.dart';
import 'package:flutter_app_first/my/pages/settings_page.dart';

typedef PageData = ({Widget page, String title});
const List<PageData> pages = [
  (page: HomePage(), title: 'Home Page'),
  (page: SettingsPage(), title: 'Settings Page'),
];

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  _LayoutWidgetState();

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pages[_index].title),
      ),
      body: pages[_index].page,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
