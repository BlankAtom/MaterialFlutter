import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/src/nav/bottom_nav.dart';
import 'package:flutter_application_4/src/pages/db_convert.dart';
import 'package:flutter_application_4/src/pages/db_health_check.dart';

// import 'package:flutter_application_4/src/nav/rail_nav.dart';
import 'package:flutter_application_4/src/tab/tab.dart';

import 'example/TabBarDemo.dart';
import 'src/nav/rail_nav.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData.dark(useMaterial3: true), home: Feed()));
}

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  // TODO: implement createState
  State<StatefulWidget> get createState => _FeedState();
}

class _FeedState extends State<Feed> {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
    _colorScheme.primary.withOpacity(0.14),
    _colorScheme.surface,
  );

  int selectedIndex = 0;

  bool wideScreen = false;

  // 浮动按钮
  Widget? getFloatActionButton() => wideScreen
      ? null
      : FloatingActionButton(
          onPressed: () {},
          backgroundColor: _colorScheme.tertiaryContainer,
          foregroundColor: _colorScheme.onTertiaryContainer,
          child: const Icon(Icons.add),
        );

  // 底部导航
  Widget? getBottomNavigationBar() => wideScreen
      ? null
      : LuffiBottomNavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: _backgroundColor,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: luffiTabs.map<NavigationDestination>((d) {
            return NavigationDestination(
              icon: Icon(d.icon),
              label: d.label,
            );
          }).toList(),
        );

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override
  Widget build(BuildContext context) {
    var list = luffiTabs.map<NavigationRailDestination>((d) {
      return NavigationRailDestination(
        icon: Icon(
          d.icon,
          size: 20,
        ),
        label: Text(d.label),
        //   padding: const EdgeInsets.symmetric(vertical: 2),
      );
    }).toList();

    return Scaffold(
      body: Row(
        children: [
          if (wideScreen)
            LuffiRailNavigationBar(
              selectedIndex: selectedIndex,
              backgroundColor: _backgroundColor,
              onDestinationSelected: (index) => setState(() {
                selectedIndex = index;
              }),
              destinations: list,

            ),
          Expanded(
            child: FeedPage(index: selectedIndex)
          ),
        ],
      ),
      floatingActionButton: getFloatActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }
}
List<Widget> pageList = <Widget>[
  DBConvertPage(),
];

class FeedPage extends StatefulWidget {

  final int index;

  const FeedPage({super.key, required this.index});

  @override
  // TODO: implement createState
  State<StatefulWidget> get createState => _FeedPage();

}

class _FeedPage extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    Widget page_widget = DBConvertPage();
    switch(widget.index) {
      case 0: page_widget = DBConvertPage(); break;
      case 1: page_widget = DBHealthCheck(); break;
    }

    return page_widget;
  }

}