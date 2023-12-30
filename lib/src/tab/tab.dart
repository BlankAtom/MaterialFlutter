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
      order: const NumericFocusOrder(1),
      child: TabBar(
        isScrollable: false,
        labelPadding: EdgeInsets.zero,
        tabs: [],
        controller: tabController,
        indicatorColor: Colors.transparent, // 隐藏标志
      ),
    );
  }
}

/// ## 主要的导航视图部件
/// 定义了部件名称、部件展开状态、部件图标和垂直方向
/// 由于是一个多状态部件，所以需要搭配另一个状态类型：LuffiTabState
class LuffiTab {
  const LuffiTab(
    this.icon,
    this.label,
  );

//   final Text titleText;
  final String label;
  final IconData icon;
//   final bool isExpanded;
//   final bool isVertical;
}

const List<LuffiTab> luffiTabs = <LuffiTab>[
  LuffiTab(Icons.inbox_rounded, '1231'),
  LuffiTab(Icons.article_outlined, '1232'),
];
