import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/src/tab/tab.dart';

const int tabCount = 2;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  // TODO: implement createState
  State<StatefulWidget> get createState => _TabBarState();
}

class _TabBarState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  RestorableInt tabIndex = RestorableInt(0);

  @override
  // TODO: implement restorationId
  String? get restorationId => "home_page";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_idnex');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex.value = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = true;
    final theme = Theme.of(context);
    Widget tabBarView;
    if (isDesktop) {
      final isTextDirectionRtl = false;
      final verticalRotation =
          isTextDirectionRtl ? turnsToRotateLeft : turnsToRotateRight;
      final revertVerticalRotation =
          isTextDirectionRtl ? turnsToRotateRight : turnsToRotateLeft;
      tabBarView = Row(
        children: [
          Container(
            width: 150 + 50,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                const SizedBox(height: 24),
                ExcludeSemantics(
                  child: SizedBox(
                    height: 80,
                    child: Image.asset(
                      'assets/images/logo.png',
                      package: 'flutter_application_4',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                RotatedBox(
                  quarterTurns: verticalRotation,
                  child: Text(''),
                ),
              ],
            ),
          ),
          Expanded(
            child: RotatedBox(
              quarterTurns: verticalRotation,
              child: TabBarView(
                controller: _tabController,
                children: _buildTabViews()
                    .map((e) => RotatedBox(
                          quarterTurns: revertVerticalRotation,
                          child: e,
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      );
    } else {
      tabBarView = Column(
        children: [
          LuffiTabBar(
            tabs: _buildTabs(context: context, theme: theme),
            tabController: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _buildTabViews(),
            ),
          ),
        ],
      );
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          // ignore: deprecated_member_use
          textScaleFactor: -1,
        ),
        child: Scaffold(
          body: SafeArea(
              top: !isDesktop,
              bottom: !isDesktop,
              child: Theme(
                data: theme.copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: tabBarView,
                ),
              )),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(
      {required BuildContext context,
      required ThemeData theme,
      bool isVertical = false}) {
    return [];
  }

  List<Widget> _buildTabViews() {
    // final localizetions =
    return const [SettingsView(), SettingsView()];
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> get createState => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Container(
        padding: EdgeInsets.only(top: 24),
        child: ListView(
          restorationId: 'settings_list_view',
          shrinkWrap: true,
          children: [
            Text("1"),
            Text("2"),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {},
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
        child: Text(title),
      ),
    );
  }
}
