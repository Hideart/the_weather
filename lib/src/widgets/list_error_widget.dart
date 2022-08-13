import 'package:flutter/material.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class ListError extends StatelessWidget {
  const ListError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ThemedText(
          'Something went wrong 😒',
          type: ThemedTextType.primary,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
