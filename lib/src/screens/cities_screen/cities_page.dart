import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/src/screens/cities_screen/bloc/cities_cubit.dart';
import 'package:the_weather/src/screens/cities_screen/cities_view.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitiesCubit()..getCities(page: 1),
      child: const CitiesView(),
    );
  }
}
