import 'package:flutter_app_first/my/layouts/layout.dart';
import 'package:flutter_app_first/my/layouts/layout_page.dart';
import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:flutter_app_first/my/pages/counter_page.dart';
import 'package:flutter_app_first/my/pages/drawer_page.dart';
import 'package:flutter_app_first/my/pages/json_placeholder_page.dart';
import 'package:flutter_app_first/my/pages/storage/cart_page.dart';
import 'package:flutter_app_first/my/pages/storage/create_item_page.dart';
import 'package:flutter_app_first/my/pages/storage/storage_page.dart';
import 'package:flutter_app_first/my/pages/ws_echo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LayoutWidget(),
      routes: [
        GoRoute(
          path: 'counter',
          builder: (context, state) => LayoutPageWidget(
            title: 'Counter Page',
            page: const CounterPage(),
          ),
        ),
        GoRoute(
          path: 'json-placeholder',
          builder: (context, state) => LayoutPageWidget(
            title: 'Json Placeholder Page',
            page: JsonPlaceholderPage(),
          ),
        ),
        GoRoute(
          path: 'ws-echo',
          builder: (context, state) =>
              LayoutPageWidget(title: 'Ws Echo Page', page: WsEchoPage()),
        ),
        GoRoute(
          path: 'drawer',
          builder: (context, state) => DrawerPage(title: 'Drawer Page'),
        ),
        GoRoute(
          path: 'storage',
          builder: (context, state) => const StoragePage(),
          routes: [
            GoRoute(
              path: 'create-item',
              builder: (context, state) {
                final storageCubit = state.extra! as StorageCubit;
                return BlocProvider.value(
                  value: storageCubit,
                  child: const CreateItemPage(),
                );
              },
            ),
            GoRoute(
              path: 'cart',
              builder: (context, state) {
                final cartCubit = state.extra! as CartCubit;
                return BlocProvider.value(
                  value: cartCubit,
                  child: const CartPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
