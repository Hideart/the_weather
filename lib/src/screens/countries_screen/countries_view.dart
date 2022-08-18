import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/app_state/geo/geo_state.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/screens/countries_screen/bloc/countries_cubit.dart';
import 'package:the_weather/src/screens/countries_screen/bloc/countries_state.dart';
import 'package:the_weather/src/utils/service_locator.dart';
import 'package:the_weather/src/widgets/menu_item_widget.dart';
import 'package:the_weather/src/widgets/searchable_screen_content_widget.dart';
import 'package:the_weather/src/widgets/themed_menu_list_widget.dart';
import 'package:the_weather/src/widgets/themed_screen_wrapper_widget.dart';

class CountriesView extends StatefulWidget {
  const CountriesView({Key? key}) : super(key: key);

  @override
  State<CountriesView> createState() => _CountriesViewState();
}

class _CountriesViewState extends State<CountriesView> {
  Timer? debounce;
  String? searchValue;

  void handleUpdateCountries(BuildContext context, int page) {
    context
        .read<CountriesCubit>()
        .getCountries(page: page, search: this.searchValue);
  }

  void handleSearch(BuildContext context, String value) {
    if (this.debounce?.isActive ?? false) this.debounce!.cancel();
    this.debounce = Timer(const Duration(milliseconds: 1000), () {
      if (this.searchValue != value) {
        this.setState(() {
          this.searchValue = value;
        });
      }
      this.handleUpdateCountries(context, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          return ThemedScreenWrapper(
            appBarData: ThemedAppBarData(
              title: 'Select a country',
              collapsable: false,
              pinned: true,
            ),
            children: [
              SearchableScreenContent(
                loading: state.loading,
                error: state.error && state.list.isEmpty,
                page: state.page,
                totalPages: state.totalPages,
                onPaginationForward: () => this.handleUpdateCountries(
                  context,
                  state.page + 1,
                ),
                onPaginationBackward: () => this.handleUpdateCountries(
                  context,
                  state.page - 1,
                ),
                onSearch: (value) => this.handleSearch(context, value),
                child: BlocBuilder<GeoStateCubit, GeoState>(
                  builder: (context, geoState) => MenuItemsList(
                    items: state.list
                        .map<MenuItemData>(
                          (item) => MenuItemData(
                            '${item.name.length > 20 ? '${item.name.substring(0, 20)}...' : item.name}, ${item.code}',
                            icon: geoState.countryCode == item.code
                                ? const Icon(
                                    Icons.check,
                                    size: AppMetrics.TITLE_SIZE,
                                  )
                                : null,
                            onTap: () => DI
                                .get<GeoStateCubit>(
                                  instanceName: 'geo_state',
                                )
                                .setCountry(item.code),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
