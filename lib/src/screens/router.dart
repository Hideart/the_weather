import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/screens/cities_screen/cities_page.dart';
import 'package:the_weather/src/screens/countries_screen/countries_page.dart';
import 'package:the_weather/src/screens/home_screen/home_page.dart';
import 'package:the_weather/src/screens/settings_screen/settings_page.dart';

GoRouter appRouter(GeoStateCubit geoStateCubit) => GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const CupertinoPage<void>(
            child: HomePage(),
          ),
          redirect: (_) =>
              geoStateCubit.state.city == null ? '/settings' : null,
          routes: [
            GoRoute(
              path: 'settings',
              pageBuilder: (context, state) => const CupertinoPage<void>(
                child: SettingsPage(),
              ),
              routes: [
                GoRoute(
                  path: 'countries',
                  pageBuilder: (context, state) => const CupertinoPage<void>(
                    child: CountriesPage(),
                  ),
                ),
                GoRoute(
                  path: 'cities',
                  pageBuilder: (context, state) => const CupertinoPage<void>(
                    child: CitiesPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      refreshListenable: geoStateCubit,
    );
