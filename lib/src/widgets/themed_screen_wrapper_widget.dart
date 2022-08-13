import 'package:flutter/material.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';
import 'package:the_weather/packages/widgets/screen_wrapper_widget/screen_wrapper_widget.dart';
import 'package:the_weather/src/metrics.dart';

class ThemedAppBarData extends PasstoreAppBarData {
  ThemedAppBarData({
    required super.title,
    super.collapsable,
    super.pinned,
    super.rightContent,
    super.applyBottomBorder,
    super.disablePop,
    super.titleScaleFactor,
  });
}

class ThemedScreenWrapper extends StatelessWidget {
  final List<Widget> children;
  final ThemedAppBarData? appBarData;
  const ThemedScreenWrapper({Key? key, required this.children, this.appBarData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return PasstoreScreenWrapper(
      appBar: this.appBarData != null
          ? PasstoreAppBarData(
              title: this.appBarData!.title,
              collapsable: this.appBarData!.collapsable,
              pinned: this.appBarData!.pinned,
              rightContent: this.appBarData!.rightContent,
              applyBottomBorder: this.appBarData!.applyBottomBorder,
              disablePop: this.appBarData!.disablePop,
              titleScaleFactor: this.appBarData!.titleScaleFactor,
              headerSize: AppMetrics.HEADER_SIZE,
              blurMultiplier: AppMetrics.BLUR_MULTIPLIER,
              defaultMargin: AppMetrics.DEFAULT_MARGIN,
              littleMargin: AppMetrics.LITTLE_MARGIN,
              borderRadius: AppMetrics.BORDER_RADIUS,
              titleSize: AppMetrics.TITLE_SIZE,
              textColor: theme.textPrimaryColor,
            )
          : null,
      backgroundGradient: LinearGradient(
        colors: [theme.darkBackgroundColor, theme.darkBackgroundColor],
        end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
      ),
      defaultMargin: AppMetrics.DEFAULT_MARGIN,
      children: this.children,
    );
  }
}
