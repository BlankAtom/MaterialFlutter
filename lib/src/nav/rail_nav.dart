import 'package:flutter/material.dart';

class LuffiRailNavigationBar extends StatefulWidget {
  LuffiRailNavigationBar({
    required this.selectedIndex,
    required this.backgroundColor,
    required this.destinations,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final Color backgroundColor;
  final List<NavigationRailDestination> destinations;
  final ValueChanged<int>? onDestinationSelected;

  @override
  State<StatefulWidget> get createState => _LuffiRailNavigationBar();
}

class _LuffiRailNavigationBar extends State<LuffiRailNavigationBar> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    // 从目标类型读取状态数据
    final scheme = Theme.of(context).colorScheme;

    // 选中的序号
    final selectedIndex = widget.selectedIndex;

    // 当选中按钮时回调
    final onDestinationSelected = widget.onDestinationSelected;

    // 列表
    final destinations = widget.destinations;

    // 背景颜色
    final backgroundColor = widget.backgroundColor;

    return NavigationRail(
      extended: true == isExtended, // 是否展开
      selectedIndex: selectedIndex, // 当前选中的顺序
      useIndicator: true, // 选中指示器
      indicatorColor: scheme.onTertiary, // 指示器颜色
      // 指示器形状
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      backgroundColor: backgroundColor, // 背景颜色
      onDestinationSelected: onDestinationSelected, // 选中导航时的回调
      groupAlignment: -0.85, // 组间隔
      leading: Column(
        children: [
          IconButton(
            alignment: Alignment.bottomLeft, // 形状内布局
            icon: const Icon(Icons.menu), // 图标
            onPressed: () => {
              setState(
                () => isExtended = !isExtended,
              ),
            },
          ),
          // 尺寸盒子，用于分割组件
          const SizedBox(
            height: 8,
          ),
          // 浮动事件按钮，此处为 Logo 位
          FloatingActionButton(
            // 背景颜色
            backgroundColor: scheme.tertiaryContainer,
            // 前景颜色
            foregroundColor: scheme.onTertiaryContainer,
            // 按钮形状
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      destinations: destinations,
      trailing: const Icon(
        Icons.ice_skating
      ),
    );
  }
}
