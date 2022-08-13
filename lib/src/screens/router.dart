import 'package:flutter/material.dart';
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
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage(),
          redirect: (_) =>
              geoStateCubit.state.city == null ? '/settings' : null,
          routes: [
            GoRoute(
              path: 'settings',
              builder: (BuildContext context, GoRouterState state) =>
                  const SettingsPage(),
              routes: [
                GoRoute(
                  path: 'countries',
                  builder: (BuildContext context, GoRouterState state) =>
                      const CountriesPage(),
                ),
                GoRoute(
                  path: 'cities',
                  builder: (BuildContext context, GoRouterState state) =>
                      const CitiesPage(),
                ),
              ],
            ),
          ],
        ),
      ],
      refreshListenable: geoStateCubit,
    );
