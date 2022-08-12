import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/models/theme_model.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class MenuItemData {
  final String text;
  final String? value;
  final Widget? icon;
  final bool hasChildren;
  final Color? textColor;
  final Color? hoverColor;
  final Color? splashColor;
  final void Function() onTap;
  final void Function(TapDownDetails)? onTapDown;

  MenuItemData(
    this.text, {
    this.value,
    this.icon,
    this.hasChildren = false,
    this.textColor,
    this.hoverColor,
    this.splashColor,
    this.onTapDown,
    required this.onTap,
  });
}

class ThemedMenuItem extends StatelessWidget implements MenuItemData {
  @override
  final String text;
  @override
  final String? value;
  @override
  final Widget? icon;
  @override
  final bool hasChildren;
  @override
  final Color? textColor;
  @override
  final Color? hoverColor;
  @override
  final Color? splashColor;
  @override
  final void Function() onTap;
  @override
  final void Function(TapDownDetails details)? onTapDown;

  final bool needSeparator;

  const ThemedMenuItem(
    this.text, {
    Key? key,
    this.value,
    this.icon,
    this.hasChildren = false,
    this.needSeparator = true,
    this.textColor,
    this.hoverColor,
    this.splashColor,
    required this.onTap,
    this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      children: [
        Tapable(
          properties: TapableProps(
            enableTapAnimation: false,
            padding: const EdgeInsets.only(
              top: AppMetrics.LITTLE_MARGIN,
              bottom: AppMetrics.LITTLE_MARGIN,
              right: AppMetrics.LITTLE_MARGIN,
            ),
            onTap: this.onTap,
            onTapDown: this.onTapDown,
            splashColor: this.splashColor,
            hoverColor:
                this.hoverColor ?? theme.secondaryColor.withOpacity(0.6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppMetrics.BORDER_RADIUS,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppMetrics.DEFAULT_MARGIN - AppMetrics.LITTLE_MARGIN,
                bottom: AppMetrics.DEFAULT_MARGIN - AppMetrics.LITTLE_MARGIN,
                right: AppMetrics.DEFAULT_MARGIN - AppMetrics.LITTLE_MARGIN,
                left: AppMetrics.DEFAULT_MARGIN - AppMetrics.LITTLE_MARGIN,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppMetrics.DEFAULT_MARGIN -
                              AppMetrics.LITTLE_MARGIN,
                          right: AppMetrics.DEFAULT_MARGIN,
                        ),
                        child: Container(
                          width: AppMetrics.LITTLE_MARGIN * 2,
                          constraints: const BoxConstraints(
                            maxWidth: AppMetrics.LITTLE_MARGIN * 2,
                          ),
                          child: this.icon ?? const SizedBox(),
                        ),
                      ),
                      ThemedText(
                        this.text,
                        type: ThemedTextType.primary,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: this.textColor ?? theme.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      this.value != null && this.value!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                right: AppMetrics.LITTLE_MARGIN / 2,
                              ),
                              child: ThemedText(
                                this.value!,
                                style: TextStyle(
                                  fontSize: AppMetrics.LITTLE_TEXT_SIZE,
                                  color: theme.textPaleColor,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      this.hasChildren
                          ? Icon(
                              Icons.arrow_forward_ios,
                              color: theme.textPaleColor,
                              size: AppMetrics.DEFAULT_MARGIN,
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        this.needSeparator
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppMetrics.DEFAULT_MARGIN * 2 +
                            AppMetrics.LITTLE_MARGIN * 2 -
                            (AppMetrics.DEFAULT_MARGIN -
                                AppMetrics.LITTLE_MARGIN),
                      ),
                      child: Container(
                        height: 1,
                        color: theme.secondaryColor,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
