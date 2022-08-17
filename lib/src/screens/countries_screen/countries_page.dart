import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/src/screens/countries_screen/bloc/countries_cubit.dart';
import 'package:the_weather/src/screens/countries_screen/countries_view.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountriesCubit()..getCountries(page: 1),
      child: const CountriesView(),
    );
  }
}
