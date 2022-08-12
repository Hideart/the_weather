import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/models/theme_model.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

enum ButtonType { primary, secondary, disabled, reject, approve }

class ThemedButton extends StatelessWidget {
  final String? text;
  final bool enableStartAnimation;
  final TimelineSyncFunction onTap;
  final ButtonType type;

  const ThemedButton({
    required this.onTap,
    this.enableStartAnimation = false,
    this.text,
    this.type = ButtonType.primary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    Map<String, Color> buttonColors = {};
    switch (this.type) {
      case ButtonType.secondary:
        buttonColors.addAll({
          'background': theme.buttons.secondaryBackground,
          'splash': theme.buttons.secondarySplashColor,
          'text': theme.buttons.secondaryTextColor,
        });
        break;
      case ButtonType.disabled:
        buttonColors.addAll({
          'background': theme.buttons.disabledBackground,
          'splash': theme.buttons.disabledSplashColor,
          'text': theme.buttons.disabledTextColor,
        });
        break;
      case ButtonType.approve:
        buttonColors.addAll({
          'background': theme.buttons.approveBackground,
          'splash': theme.buttons.approveSplashColor,
          'text': theme.buttons.approveTextColor,
        });
        break;
      case ButtonType.reject:
        buttonColors.addAll({
          'background': theme.buttons.rejectBackground,
          'splash': theme.buttons.rejectSplashColor,
          'text': theme.buttons.rejectTextColor,
        });
        break;
      default:
        buttonColors.addAll({
          'background': theme.buttons.primaryBackground,
          'splash': theme.buttons.primarySplashColor,
          'text': theme.buttons.primaryTextColor,
        });
        break;
    }

    return Row(
      children: [
        Tapable(
          properties: TapableProps(
            onTap: this.onTap,
            enableStartAnimation: this.enableStartAnimation,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppMetrics.BORDER_RADIUS),
              color: buttonColors['background'],
            ),
            splashColor: buttonColors['splash'],
            padding: const EdgeInsets.all(AppMetrics.LITTLE_MARGIN),
            child: this.text != null
                ? ThemedText(
                    this.text!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: buttonColors['text'],
                    ),
                    type: ThemedTextType.primary,
                    textAlign: TextAlign.center,
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
