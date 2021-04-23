import 'package:flutter/material.dart';

import 'commodity_list_normal.dart';

//商品列表页面主页面
class CommodityListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('商品列表'),
        elevation: 0.0,
      ),
      body: CommodityListHome(),
    );
  }
}
