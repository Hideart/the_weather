import 'package:flutter/material.dart';
import 'appbar_widget.dart';

export 'appbar_widget.dart';

class SafeAreaEnables {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const SafeAreaEnables.at({
    this.left = false,
    this.right = false,
    this.bottom = false,
    this.top = false,
  });
}

class PasstoreScreenWrapper extends StatelessWidget {
  final List<Widget> children;
  final PasstoreAppBarData? appBar;
  final double expandedHeight = 100.0;
  final PageStorageKey<String>? contentKey;
  final SafeAreaEnables safeAreaEnabledAt;
  final LinearGradient? backgroundGradient;
  final double defaultMargin;
  final EdgeInsets? padding;

  const PasstoreScreenWrapper({
    Key? key,
    this.appBar,
    required this.children,
    this.contentKey,
    this.safeAreaEnabledAt = const SafeAreaEnables.at(
      top: false,
      bottom: false,
      left: false,
      right: false,
    ),
    this.backgroundGradient,
    this.defaultMargin = 15.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: this.backgroundGradient ??
                LinearGradient(
                  colors: [Colors.grey, Colors.grey.shade500],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                ),
          ),
        ),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            key: this.contentKey,
            slivers: <Widget>[
              this.appBar != null
                  ? PasstoreAppBar(data: this.appBar!)
                  : const SliverPadding(padding: EdgeInsets.all(0)),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: this.appBar == null && this.safeAreaEnabledAt.top
                      ? safeArea.top + (this.padding?.top ?? 0)
                      : this.padding?.top ?? 0,
                  bottom: this.safeAreaEnabledAt.bottom
                      ? safeArea.bottom + (this.padding?.bottom ?? 0)
                      : this.padding?.bottom ?? 0,
                  left: this.padding?.left ?? 0,
                  right: this.padding?.right ?? 0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => this.children[index],
                    childCount: this.children.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
