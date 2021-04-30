import 'package:flutter/material.dart';

import 'common/TapRipple/TapWidget2.dart';

void main() {
  runApp(CommodityInfo());
}

class CommodityInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:
          // TapWidget1());
          new Center(
              child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TapWidget2(),
        ],
      )),
    );
  }
}
