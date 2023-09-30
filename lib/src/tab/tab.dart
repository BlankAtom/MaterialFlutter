import 'package:flutter/material.dart';

const int tabCount = 2;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

/// ## 导航栏
/// 无状态导航栏，具体动画和视图由 LuffiTab定义
class LuffiTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;

  const LuffiTabBar({
    required this.tabs,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
        order: const NumericFocusOrder(0),
        child: TabBar(
          isScrollable: true,
          labelPadding: EdgeInsets.zero,
          tabs: tabs,
          controller: tabController,
          indicatorColor: Colors.transparent, // 隐藏标志
        ));
  }
}

/// ## 主要的导航视图部件
/// 定义了部件名称、部件展开状态、部件图标和垂直方向
/// 由于是一个多状态部件，所以需要搭配另一个状态类型：LuffiTabState
class LuffiTab extends StatefulWidget {
  LuffiTab({
    required ThemeData theme,
    IconData? iconData,
    required String title,
    int? tabIndex,
    required TabController tabController,
    required this.isVertical,
  })  : titleText = Text(
          title,
          style: theme.textTheme.labelLarge,
        ),
        isExpanded = tabController.index == tabIndex,
        icon = Icon(iconData, semanticLabel: title);

  final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;

  @override
  State<StatefulWidget> get createState => LuffiTabState();
}

class LuffiTabState extends State<LuffiTab>
    with SingleTickerProviderStateMixin {
  /// 标题尺寸动画
  late Animation<double> _titleSizeAnimation;

  /// 标题渐变
  late Animation<double> _titleFadeAnimation;

  /// 图标渐变动画
  late Animation<double> _iconFadeAnimation;

  /// 动画控制器
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));

    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(LuffiTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVertical) {
      return Column(
        children: [
          const SizedBox(height: 18),
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: widget.icon,
          ),
          const SizedBox(height: 12),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.vertical,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: Center(child: ExcludeSemantics(child: widget.titleText)),
            ),
          ),
          const SizedBox(height: 18),
        ],
      );
    }

    // Calculate the width of each unexpanded tab by counting the number of
    // units and dividing it into the screen width. Each unexpanded tab is 1
    // unit, and there is always 1 expanded tab which is 1 unit + any extra
    // space determined by the multiplier.
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 2;
    final unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
          ),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(
                  child: ExcludeSemantics(child: widget.titleText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
