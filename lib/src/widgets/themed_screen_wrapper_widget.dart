import 'package:flutter/foundation.dart';
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
  final ThemedAppBarData? appBarData;
  final EdgeInsets padding;
  final List<Widget> children;
  final SafeAreaEnables safeAreaEnabledAt;
  final AsyncCallback? onRefresh;
  final bool? loading;
  final ScrollController? scrollController;

  const ThemedScreenWrapper({
    Key? key,
    required this.children,
    this.appBarData,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppMetrics.DEFAULT_MARGIN),
    this.safeAreaEnabledAt = const SafeAreaEnables.at(top: true, bottom: true),
    this.onRefresh,
    this.loading,
    this.scrollController,
  }) : super(key: key);

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
      padding: this.padding,
      safeAreaEnabledAt: this.safeAreaEnabledAt,
      backgroundGradient: LinearGradient(
        colors: [theme.darkBackgroundColor, theme.darkBackgroundColor],
        end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
      ),
      defaultMargin: AppMetrics.DEFAULT_MARGIN,
      onRefresh: this.onRefresh,
      loading: this.loading,
      scrollController: this.scrollController,
      children: this.children,
    );
  }
}
