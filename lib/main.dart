import 'package:flutter_app_first/drag/drag_app.dart';
import 'package:flutter_app_first/game/game_app.dart';
import 'package:flutter_app_first/my/my_app.dart';
import 'package:flutter_app_first/rolodex/rolodex_app.dart';
import 'package:flutter_app_first/wiki/wiki_app.dart';
import 'package:material_ui/material_ui.dart';

enum App {
  my(MyApp.new),
  wiki(WikiApp.new),
  rolodex(RolodexApp.new),
  game(GameApp.new),
  drag(DragApp.new),
  ;

  const App(this.widget);

  final Widget Function() widget;
}

void main() {
  runApp(App.drag.widget());
}
