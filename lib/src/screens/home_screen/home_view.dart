import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';
import 'package:the_weather/packages/repositories/weather/weather_model.dart';
import 'package:the_weather/packages/widgets/centered_loader.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/app_state/geo/geo_state.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/screens/home_screen/bloc/weather_cubit.dart';
import 'package:the_weather/src/screens/home_screen/bloc/weather_state.dart';
import 'package:the_weather/src/widgets/list_error_widget.dart';
import 'package:the_weather/src/widgets/themed_screen_wrapper_widget.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      body: BlocListener<GeoStateCubit, GeoState>(
        listener: (context, geoState) =>
            context.read<WeatherCubit>().updateWeather(),
        child: ThemedScreenWrapper(
          appBarData: ThemedAppBarData(
            title: 'The Weather',
            pinned: true,
            rightContent: Tapable(
              properties: TapableProps(
                padding: const EdgeInsets.all(AppMetrics.LITTLE_MARGIN / 2),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppMetrics.BORDER_RADIUS,
                    ),
                  ),
                ),
                enableStartAnimation: false,
                enableTapAnimation: false,
                onTap: () => GoRouter.of(context).go('/settings'),
                child: Icon(
                  Icons.settings_outlined,
                  color: theme.textPrimaryColor,
                ),
              ),
            ),
          ),
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state.error
                      ? const ListError()
                      : state.loading
                          ? const CenteredLoader()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: AppMetrics.DEFAULT_MARGIN,
                                ),
                                BlocBuilder<GeoStateCubit, GeoState>(
                                  builder: (context, geoState) => ThemedText(
                                    '${geoState.city}, ${geoState.countryCode}',
                                    style: const TextStyle(
                                      fontSize: AppMetrics.HEADER_SIZE,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppMetrics.DEFAULT_MARGIN * 2,
                                ),
                                Icon(
                                  WeatherIconData.values
                                      .firstWhere(
                                        (iconData) =>
                                            iconData.toString() == state.main,
                                      )
                                      .icon,
                                  size: screenSize.width / 1.8,
                                  color: theme.accentColor,
                                ),
                                ThemedText(
                                  state.main ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.accentColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppMetrics.DEFAULT_MARGIN * 2,
                                ),
                                ThemedText(
                                  '${state.temp?.current ?? 0}°',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppMetrics.TITLE_SIZE,
                                  ),
                                ),
                                ThemedText(
                                  'Feels like: ${state.temp?.feelsLike ?? 0}°',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<WeatherCubit>().updateWeather(),
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
