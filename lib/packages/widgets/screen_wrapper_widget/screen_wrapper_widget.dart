import 'package:flutter/material.dart';
import 'appbar_widget.dart';

export 'appbar_widget.dart';

class PasstoreScreenWrapper extends StatelessWidget {
  final List<Widget> children;
  final PasstoreAppBarData? appBar;
  final double expandedHeight = 100.0;
  final PageStorageKey<String>? contentKey;
  final bool enableSafeAreaTop;
  final bool enableSafeAreaBottom;
  final bool enableHorizontalInstes;
  final LinearGradient? backgroundGradient;
  final double defaultMargin;

  const PasstoreScreenWrapper({
    Key? key,
    this.appBar,
    required this.children,
    this.contentKey,
    this.enableSafeAreaBottom = true,
    this.enableSafeAreaTop = true,
    this.enableHorizontalInstes = true,
    this.backgroundGradient,
    this.defaultMargin = 15.0,
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
                  top: this.appBar == null && this.enableSafeAreaTop
                      ? safeArea.top
                      : 0,
                  bottom: this.enableSafeAreaBottom ? safeArea.bottom : 0,
                  left: this.enableHorizontalInstes ? this.defaultMargin : 0,
                  right: this.enableHorizontalInstes ? this.defaultMargin : 0,
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
