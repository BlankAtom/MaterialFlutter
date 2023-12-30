import 'package:flutter/material.dart';

class LuffiBottomNavigationBar extends StatefulWidget {
  LuffiBottomNavigationBar({
    required this.selectedIndex,
    required this.backgroundColor,
    required this.destinations,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final Color backgroundColor;
  final List<Widget> destinations;
  final ValueChanged<int>? onDestinationSelected;

  @override
  State<StatefulWidget> get createState => _LuffiBottomNavigationBarState();
}

class _LuffiBottomNavigationBarState extends State<LuffiBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // 从目标类型读取状态数据
    final selectedIndex = widget.selectedIndex;
    final onDestinationSelected = widget.onDestinationSelected;
    final destinations = widget.destinations;

    return NavigationBar(
      elevation: 8,
      backgroundColor: Colors.white,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
    );
  }
}
