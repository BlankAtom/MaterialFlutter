import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const TabBar(tabs: [
              Tab(icon: Icon(Icons.car_crash)),
              Tab(icon: Icon(Icons.bike_scooter))
            ]),

            backgroundColor: Theme.of(context).colorScheme.primary,
            // title: const Text("Hello"),
          ),
          body: const TabBarView(
            children: [Icon(Icons.turn_sharp_left), Icon(Icons.abc)],
          ),
        ),
      ),
    );
  }
}
