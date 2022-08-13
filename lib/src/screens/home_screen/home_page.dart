import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/src/screens/home_screen/bloc/weather_cubit.dart';
import 'package:the_weather/src/screens/home_screen/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit()..updateWeather(),
      child: const HomeView(),
    );
  }
}
