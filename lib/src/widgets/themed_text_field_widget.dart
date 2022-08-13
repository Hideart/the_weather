import 'package:flutter/material.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';
import 'package:the_weather/packages/widgets/tapable_widget.dart';
import 'package:the_weather/src/metrics.dart';

class ThemedTextField extends StatefulWidget {
  final Function(String value) onChange;
  final Function(bool hasFocus)? onFocus;
  const ThemedTextField({Key? key, required this.onChange, this.onFocus})
      : super(key: key);

  @override
  State<ThemedTextField> createState() => _ThemedTextFieldState();
}

class _ThemedTextFieldState extends State<ThemedTextField> {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();
  bool focused = false;

  void clearInput() {
    this._focusNode.unfocus();
    this._textController.clear();
    this.widget.onChange('');
  }

  @override
  void initState() {
    super.initState();
    this._focusNode.addListener(() {
      this.setState(() {
        this.focused = this._focusNode.hasFocus;
      });
      this.widget.onFocus?.call(this._focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    this._focusNode.dispose();
    this._textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return TextField(
      controller: this._textController,
      focusNode: this._focusNode,
      onChanged: this.widget.onChange,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.primaryColor,
        icon: this.focused
            ? Tapable(
                properties: TapableProps(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppMetrics.BORDER_RADIUS),
                    ),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: theme.textPrimaryColor,
                  ),
                  onTap: clearInput,
                ),
              )
            : null,
        prefixIcon: const Icon(Icons.search_rounded),
        labelText: 'Search',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppMetrics.DEFAULT_MARGIN,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.secondaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppMetrics.BORDER_RADIUS),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.accentColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppMetrics.BORDER_RADIUS),
          ),
        ),
      ),
    );
  }
}
