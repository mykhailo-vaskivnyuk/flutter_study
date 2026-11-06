import 'package:flutter_app_first/game/game_app.dart';
import 'package:flutter_app_first/my/my_app.dart';
import 'package:flutter_app_first/rolodex/rolodex_app.dart';
import 'package:flutter_app_first/wiki/wiki_app.dart';
import 'package:material_ui/material_ui.dart';

List<Widget> apps = [
  const MyApp(),
  const WikiApp(),
  const RolodexApp(),
  const GameApp(),
];
void main() {
  final app = apps[0];

  runApp(app);
}
