import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class PasstoreScreenWrapper extends StatefulWidget {
  final List<Widget> children;
  final PasstoreAppBarData? appBar;
  final double expandedHeight = 100.0;
  final PageStorageKey<String>? contentKey;
  final SafeAreaEnables safeAreaEnabledAt;
  final LinearGradient? backgroundGradient;
  final double defaultMargin;
  final EdgeInsets? padding;
  final AsyncCallback? onRefresh;
  final bool? refreshing;
  final ScrollController? scrollController;

  static const double refreshExtentValue = 100.0;

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
    this.onRefresh,
    this.refreshing,
    this.scrollController,
  }) : super(key: key);

  @override
  State<PasstoreScreenWrapper> createState() => _PasstoreScreenWrapperState();
}

class _PasstoreScreenWrapperState extends State<PasstoreScreenWrapper> {
  bool? lastFrameRefreshing;

  void _showRefreshIndicator(bool lastFrameRefreshing) {
    if (this.widget.scrollController == null) {
      return;
    }
    if (!lastFrameRefreshing &&
        this.widget.refreshing == true &&
        this.widget.scrollController!.offset >= 0.0) {
      this.widget.scrollController!.animateTo(
            -PasstoreScreenWrapper.refreshExtentValue,
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease.flipped,
          );
      this.lastFrameRefreshing = false;
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => this._showRefreshIndicator(!(this.widget.refreshing ?? false)),
    );
  }

  @override
  void didUpdateWidget(PasstoreScreenWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._showRefreshIndicator(oldWidget.refreshing ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    if (this.lastFrameRefreshing != null) {
      this.lastFrameRefreshing = this.widget.refreshing;
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: this.widget.backgroundGradient ??
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
            key: this.widget.contentKey,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: this.widget.scrollController,
            slivers: <Widget>[
              this.widget.appBar != null
                  ? PasstoreAppBar(data: this.widget.appBar!)
                  : const SliverPadding(padding: EdgeInsets.all(0)),
              this.widget.onRefresh != null
                  ? CupertinoSliverRefreshControl(
                      refreshTriggerPullDistance:
                          PasstoreScreenWrapper.refreshExtentValue - 1.0,
                      onRefresh: this.widget.onRefresh,
                    )
                  : const SliverPadding(padding: EdgeInsets.all(0)),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: this.widget.appBar == null &&
                          this.widget.safeAreaEnabledAt.top
                      ? safeArea.top + (this.widget.padding?.top ?? 0)
                      : this.widget.padding?.top ?? 0,
                  bottom: this.widget.safeAreaEnabledAt.bottom
                      ? safeArea.bottom + (this.widget.padding?.bottom ?? 0)
                      : this.widget.padding?.bottom ?? 0,
                  left: this.widget.padding?.left ?? 0,
                  right: this.widget.padding?.right ?? 0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => this.widget.children[index],
                    childCount: this.widget.children.length,
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
