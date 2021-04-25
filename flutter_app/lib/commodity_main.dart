import 'package:flutter/material.dart';

import 'features/commodity_list/ui/commodity_list_demo.dart';

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
      home: CommodityListDemo(),
    );
  }
}
