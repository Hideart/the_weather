import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/app_state/geo/geo_state.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/widgets/menu_item_widget.dart';
import 'package:the_weather/src/widgets/themed_menu_list_widget.dart';
import 'package:the_weather/src/widgets/themed_screen_wrapper_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      body: BlocBuilder<GeoStateCubit, GeoState>(
        builder: (context, state) => WillPopScope(
          child: ThemedScreenWrapper(
            appBarData: ThemedAppBarData(
              title: 'Settings',
              pinned: true,
              collapsable: false,
              disablePop: state.city == null,
            ),
            children: [
              Column(
                children: [
                  const SizedBox(height: AppMetrics.DEFAULT_MARGIN),
                  MenuItemsList(
                    items: [
                      MenuItemData(
                        'Country',
                        icon: Icon(
                          Icons.language,
                          color: theme.textPrimaryColor,
                        ),
                        value: state.countryCode,
                        hasChildren: true,
                        onTap: () => context.go('/settings/countries'),
                      ),
                      MenuItemData(
                        'City',
                        icon: Icon(
                          Icons.location_on_rounded,
                          color: state.countryCode == null
                              ? theme.textPaleColor
                              : theme.textPrimaryColor,
                        ),
                        value: state.city,
                        hasChildren: state.countryCode != null,
                        textColor: state.countryCode == null
                            ? theme.textPaleColor
                            : null,
                        splashColor: state.countryCode == null
                            ? Colors.transparent
                            : null,
                        onTap: state.countryCode == null
                            ? () {}
                            : () => context.go('/settings/cities'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          onWillPop: () => Future.value(state.city != null),
        ),
      ),
    );
  }
}
