import 'package:flutter/material.dart';
import 'package:flutter_app/pages/index_page.dart';

void main() {
  runApp(CommodityInfo());
}

class CommodityInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
