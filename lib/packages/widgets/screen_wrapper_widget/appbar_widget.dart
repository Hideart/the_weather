import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';

class PasstoreAppBarData {
  final String title;
  final bool collapsable;
  final bool pinned;
  final bool applyBottomBorder;
  final Widget? rightContent;
  final double titleScaleFactor;
  final bool disablePop;
  final double headerSize;
  final double defaultMargin;
  final double littleMargin;
  final double blurMultiplier;
  final double borderRadius;
  final double titleSize;
  final Color textColor;

  PasstoreAppBarData({
    this.collapsable = true,
    this.pinned = false,
    this.rightContent,
    this.headerSize = 26,
    this.applyBottomBorder = false,
    this.disablePop = false,
    this.titleScaleFactor = 1.4,
    this.blurMultiplier = 10.0,
    this.defaultMargin = 15.0,
    this.littleMargin = 10.0,
    this.borderRadius = 10.0,
    this.titleSize = 20.0,
    this.textColor = Colors.black,
    required this.title,
  });
}

class PasstoreAppBar extends StatelessWidget {
  final PasstoreAppBarData data;

  const PasstoreAppBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    double height = this.data.headerSize +
        (context.canPop() && !this.data.disablePop
            ? this.data.littleMargin
            : 0) +
        this.data.defaultMargin * 2;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: this.data.pinned,
      centerTitle: false,
      expandedHeight:
          !this.data.collapsable ? height : height * this.data.titleScaleFactor,
      collapsedHeight: height,
      backgroundColor: Colors.transparent,
      toolbarHeight: height,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            Expanded(
              child: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(this.data.defaultMargin),
                expandedTitleScale:
                    !this.data.collapsable ? 1 : this.data.titleScaleFactor,
                title: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: this.data.blurMultiplier,
                    sigmaY: this.data.blurMultiplier,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: safeAreaTop,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        context.canPop() && !this.data.disablePop
                            ? Tapable(
                                properties: TapableProps(
                                  enableStartAnimation: false,
                                  enableTapAnimation: false,
                                  padding: EdgeInsets.all(
                                    this.data.littleMargin / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        this.data.borderRadius,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_left_rounded,
                                      ),
                                      Text(
                                        this.data.title,
                                        style: TextStyle(
                                          fontSize: this.data.titleSize,
                                          fontWeight: FontWeight.bold,
                                          color: this.data.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () => GoRouter.of(context).pop(),
                                ),
                              )
                            : Text(
                                this.data.title,
                                style: TextStyle(
                                  fontSize: this.data.titleSize,
                                  fontWeight: FontWeight.bold,
                                  color: this.data.textColor,
                                ),
                              ),
                        this.data.rightContent ?? const SizedBox(),
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
