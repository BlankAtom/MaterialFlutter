import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
