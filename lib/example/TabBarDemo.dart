import 'package:flutter/material.dart';
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
      final isTextDirectionRtl = true;
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
                  child: LuffiTabBar(
                    tabs: _buildTabs(
                            context: context, theme: theme, isVertical: true)
                        .map((widget) {
                      return RotatedBox(
                        quarterTurns: revertVerticalRotation,
                        child: widget,
                      );
                    }).toList(),
                    tabController: _tabController,
                  ),
                )
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
          ))
        ],
      );
    } else {}
    return Directionality(
        textDirection: TextDirection.rtl,
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
        ));
  }

  List<Widget> _buildTabs(
      {required BuildContext context,
      required ThemeData theme,
      bool isVertical = false}) {
    return [
      LuffiTab(
        tabIndex: 0,
        iconData: Icons.pie_chart,
        theme: theme,
        title: 'title',
        tabController: _tabController,
        isVertical: isVertical,
      ),
      LuffiTab(
        tabIndex: 1,
        iconData: Icons.pie_chart,
        theme: theme,
        title: 'title1',
        tabController: _tabController,
        isVertical: isVertical,
      )
    ];
  }

  List<Widget> _buildTabViews() {
    // final localizetions =
    return const [OverviewView(), OverviewView()];
  }
}

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> get createState => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      restorationId: 'overview_scroll_view',
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            //   _AlertsView(alerts: alerts.sublist(0, 1)),
            SizedBox(height: 12),
            //   const _OverviewGrid(spacing: 12),
          ],
        ),
      ),
    );
  }
}
