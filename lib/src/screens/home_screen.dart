import 'package:flutter/material.dart';
import 'package:the_weather/src/widgets/header_widget.dart';
import 'package:the_weather/src/widgets/themed_screen_wrapper_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemedScreenWrapper(
      header: ThemedHeaderData(
        title: 'The Weather',
        pinned: true,
      ),
      children: const [],
    );
  }
}
