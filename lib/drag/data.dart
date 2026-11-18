import 'package:flutter_app_first/drag/models.dart';
import 'package:material_ui/material_ui.dart';

const urlPrefix =
    'https://docs.flutter.dev/assets/images/exercise/effects/split-check';

const List<Item> items = [
  Item(
    name: 'Spinach Pizza',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: NetworkImage('$urlPrefix/Food1.jpg'),
  ),
  Item(
    name: 'Veggie Delight',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: NetworkImage('$urlPrefix/Food2.jpg'),
  ),
  Item(
    name: 'Chicken Parmesan',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: NetworkImage('$urlPrefix/Food3.jpg'),
  ),
];
