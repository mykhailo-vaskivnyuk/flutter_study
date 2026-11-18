import 'package:flutter_app_first/drag/page.dart';
import 'package:material_ui/material_ui.dart';

class DragApp extends StatelessWidget {
  const DragApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleDragAndDrop(),
      debugShowCheckedModeBanner: false,
    );
  }
}
