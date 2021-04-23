import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commodity_details_demo.dart';

class DtailsNormalList extends StatelessWidget {
  final String pageTitle;

  DtailsNormalList({this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          DetailsPage(),
        ],
      ),
    );
  }
}
