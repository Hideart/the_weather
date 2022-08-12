import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class ThemedHeaderData {
  final String title;
  final bool collapsable;
  final bool pinned;
  final bool applyBottomBorder;
  final Widget? rightContent;
  final double? collapsedHeight;
  final double? expandedHeight;
  final double titleScaleFactor;

  ThemedHeaderData({
    this.collapsable = true,
    this.pinned = false,
    this.applyBottomBorder = false,
    this.rightContent,
    this.collapsedHeight,
    this.expandedHeight,
    this.titleScaleFactor = 1.3,
    required this.title,
  });
}

class ThemedHeader extends StatelessWidget {
  final String title;
  final bool collapsable;
  final bool pinned;
  final Widget? rightContent;
  final double? collapsedHeight;
  final double? expandedHeight;
  final double titleScaleFactor;
  final bool applyBottomBorder;

  const ThemedHeader({
    Key? key,
    this.collapsable = true,
    this.pinned = false,
    this.rightContent,
    this.applyBottomBorder = false,
    this.collapsedHeight,
    this.expandedHeight,
    this.titleScaleFactor = 1.4,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final double height = (this.collapsedHeight ?? AppMetrics.HEADER_SIZE) +
        AppMetrics.DEFAULT_MARGIN * 2 +
        (this.rightContent != null ? AppMetrics.LITTLE_MARGIN * 2 : 0);
    return SliverAppBar(
      elevation: 0,
      pinned: this.pinned,
      centerTitle: false,
      expandedHeight: height * this.titleScaleFactor,
      collapsedHeight: height,
      backgroundColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            Expanded(
              child: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(AppMetrics.DEFAULT_MARGIN),
                expandedTitleScale: this.titleScaleFactor,
                title: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: AppMetrics.BLUR_MULTIPLIER,
                    sigmaY: AppMetrics.BLUR_MULTIPLIER,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: safeAreaTop > 0.0 ? safeAreaTop : 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ThemedText(
                          this.title,
                          type: ThemedTextType.primary,
                          style: const TextStyle(
                            fontSize: AppMetrics.TITLE_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: this.rightContent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
