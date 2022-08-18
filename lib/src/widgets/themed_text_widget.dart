import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';

enum ThemedTextType { primary, secondary }

class ThemedText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLength;
  final bool needElipsis;
  final ThemedTextType type;

  const ThemedText(
    this.data, {
    this.type = ThemedTextType.secondary,
    Key? key,
    this.style,
    this.textAlign,
    this.maxLength,
    this.needElipsis = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    Color textColor = type == ThemedTextType.primary
        ? theme.textPrimaryColor
        : theme.textSecondaryColor;
    final TextStyle themedStyle = TextStyle(
      color: this.style?.color ?? textColor,
      fontSize: this.style?.fontSize ?? AppMetrics.TEXT_SIZE,
      fontWeight: this.style?.fontWeight ?? FontWeight.normal,
      inherit: this.style?.inherit ?? true,
      backgroundColor: this.style?.backgroundColor,
      fontStyle: this.style?.fontStyle,
      letterSpacing: this.style?.letterSpacing,
      wordSpacing: this.style?.wordSpacing,
      textBaseline: this.style?.textBaseline,
      height: this.style?.height,
      leadingDistribution: this.style?.leadingDistribution,
      locale: this.style?.locale,
      foreground: this.style?.foreground,
      background: this.style?.background,
      shadows: this.style?.shadows,
      fontFeatures: this.style?.fontFeatures,
      decoration: this.style?.decoration,
      decorationColor: this.style?.decorationColor,
      decorationStyle: this.style?.decorationStyle,
      decorationThickness: this.style?.decorationThickness,
      debugLabel: this.style?.debugLabel,
      overflow: this.style?.overflow,
      fontFamily: 'CenturyGothic',
    );

    final String finalText = this.maxLength != null &&
            this.data.length > this.maxLength!
        ? '${this.data.substring(0, this.maxLength! - 1)}${this.needElipsis ? '...' : ''}'
        : this.data;

    return Text(
      finalText,
      style: themedStyle,
      textAlign: this.textAlign,
      key: ValueKey(theme.name),
    );
  }
}
