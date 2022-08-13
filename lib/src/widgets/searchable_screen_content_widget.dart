import 'package:flutter/material.dart';
import 'package:the_weather/packages/widgets/centered_loader.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';
import 'package:the_weather/src/metrics.dart';
import 'package:the_weather/src/widgets/list_error_widget.dart';
import 'package:the_weather/src/widgets/themed_text_field_widget.dart';
import 'package:the_weather/src/widgets/themed_text_widget.dart';

class SearchableScreenContent extends StatefulWidget {
  final bool loading;
  final bool error;
  final int page;
  final int totalPages;
  final Widget child;
  final void Function() onPaginationForward;
  final void Function() onPaginationBackward;
  final void Function(String value) onSearch;

  const SearchableScreenContent({
    Key? key,
    required this.loading,
    required this.error,
    required this.page,
    required this.totalPages,
    required this.child,
    required this.onPaginationForward,
    required this.onPaginationBackward,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchableScreenContent> createState() =>
      _SearchableScreenContentState();
}

class _SearchableScreenContentState extends State<SearchableScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.widget.error
          ? const [
              Padding(
                padding: EdgeInsets.only(top: AppMetrics.DEFAULT_MARGIN),
                child: ListError(),
              )
            ]
          : [
              const SizedBox(height: AppMetrics.DEFAULT_MARGIN),
              ThemedTextField(
                onChange: this.widget.onSearch,
              ),
              const SizedBox(height: AppMetrics.DEFAULT_MARGIN),
              this.widget.loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: AppMetrics.DEFAULT_MARGIN),
                      child: CenteredLoader(),
                    )
                  : this.widget.child,
              const SizedBox(height: AppMetrics.DEFAULT_MARGIN),
              !this.widget.loading
                  ? Container(
                      margin: const EdgeInsets.only(
                        bottom: AppMetrics.DEFAULT_MARGIN,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          this.widget.page != 1
                              ? Tapable(
                                  properties: TapableProps(
                                    padding: const EdgeInsets.all(
                                      AppMetrics.LITTLE_MARGIN / 2,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          AppMetrics.BORDER_RADIUS,
                                        ),
                                      ),
                                    ),
                                    onTap: this.widget.onPaginationBackward,
                                    child: const Icon(
                                      Icons.keyboard_arrow_left_rounded,
                                      size: AppMetrics.HEADER_SIZE,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: AppMetrics.LITTLE_MARGIN / 2 +
                                      AppMetrics.HEADER_SIZE,
                                ),
                          ThemedText(
                            '${this.widget.page}/${this.widget.totalPages}',
                          ),
                          this.widget.totalPages != this.widget.page
                              ? Tapable(
                                  properties: TapableProps(
                                    padding: const EdgeInsets.all(
                                      AppMetrics.LITTLE_MARGIN / 2,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          AppMetrics.BORDER_RADIUS,
                                        ),
                                      ),
                                    ),
                                    onTap: this.widget.onPaginationForward,
                                    child: const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: AppMetrics.HEADER_SIZE,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: AppMetrics.LITTLE_MARGIN / 2 +
                                      AppMetrics.HEADER_SIZE,
                                ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
    );
  }
}
