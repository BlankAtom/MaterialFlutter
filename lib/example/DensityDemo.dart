import 'package:flutter/material.dart';
import 'package:flutter_application_4/example/TabBarDemo.dart';

class DensityAmtDemo extends StatelessWidget {
  bool touchMode = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double desityAmt = touchMode ? 0.0 : -1.0;

    VisualDensity density =
        VisualDensity(horizontal: desityAmt, vertical: desityAmt);

    return MaterialApp(
      theme: ThemeData(),
      home: TabBarDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
