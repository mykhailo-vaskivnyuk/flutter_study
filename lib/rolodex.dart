import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_app_first/rolodex/data/contact_group_model.dart';
import 'package:flutter_app_first/rolodex/screens/adaptive_layout.dart';

final contactGroupsModel = ContactGroupsModel();

class RolodexApp extends StatelessWidget {
  const RolodexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Rolodex',
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoDynamicColor.withBrightness(
          color: Color(0xFFF9F9F9),
          darkColor: Color(0xFF1D1D1D),
        ),
      ),
      home: AdaptiveLayout(),
    );
  }
}
