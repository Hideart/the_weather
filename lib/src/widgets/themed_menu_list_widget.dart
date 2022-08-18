import 'package:flutter/material.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';
import 'package:the_weather/src/widgets/menu_item_widget.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class MenuItemsList extends StatelessWidget {
  final List<MenuItemData> items;
  final String? title;

  const MenuItemsList({Key? key, this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this.title != null && this.title!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                  left: AppMetrics.DEFAULT_MARGIN,
                  bottom: AppMetrics.DEFAULT_MARGIN,
                ),
                child: ThemedText(
                  this.title!.toUpperCase(),
                  type: ThemedTextType.secondary,
                  style: const TextStyle(
                    fontSize: AppMetrics.LITTLE_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(AppMetrics.BORDER_RADIUS),
                  border: Border.all(color: theme.secondaryColor),
                ),
                child: Column(
                  children: this
                      .items
                      .map(
                        (item) => ThemedMenuItem(
                          item.text,
                          data: item,
                          needSeparator: item != this.items.last,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
