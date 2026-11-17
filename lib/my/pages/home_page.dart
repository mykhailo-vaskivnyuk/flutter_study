import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/widgets/home_nav_button.dart';
import 'package:go_router/go_router.dart';

typedef HomeButtonData = ({String label, String path});

const List<HomeButtonData> pages = [
  (label: 'Counter Page', path: '/counter'),
  (label: 'Json Placeholder Page', path: '/json-placeholder'),
  (label: 'Ws Echo Page', path: '/ws-echo'),
  (label: 'Drawer Page', path: '/drawer'),
  (label: 'Storage Page', path: '/storage'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: pages
            .map(
              (button) => HomeNavButton(
                label: button.label,
                onPressed: () => context.push(button.path),
              ),
            )
            .toList(),
      ),
    );
  }
}
