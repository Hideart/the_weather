import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/models/theme_model.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class ThemedModalContent extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? message;

  const ThemedModalContent({this.child, this.title, this.message, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppMetrics.DEFAULT_MARGIN),
          constraints: const BoxConstraints(minHeight: 150),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(AppMetrics.BORDER_RADIUS),
            border: Border.all(color: theme.secondaryColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title
              this.title != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppMetrics.DEFAULT_MARGIN,
                          ),
                          child: ThemedText(
                            this.title!,
                            type: ThemedTextType.primary,
                            style: const TextStyle(
                              fontSize: AppMetrics.TITLE_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
              // Content
              this.child == null && this.message != null
                  ? ThemedText(
                      this.message!,
                      type: ThemedTextType.primary,
                      style: const TextStyle(fontSize: AppMetrics.TEXT_SIZE),
                    )
                  : const SizedBox(),
              this.child != null ? this.child! : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
