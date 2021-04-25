import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/commodity_list_http.dart';

import 'commodity_details_normal_demo.dart';

//商品列表页面列表控件
class CommodityListHome extends StatefulWidget {
  @override
  _CommodityListHomeState createState() => _CommodityListHomeState();
}

class _CommodityListHomeState extends State<CommodityListHome> {
  @override
  void initState() {
    super.initState();
    fetchCommodityLists();
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> _onRefresh() async {
      await Future.delayed(Duration(seconds: 3), () {
        print('refresh');
        setState(() {
          fetchCommodityLists();
        });
      });
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: FutureBuilder(
        future: fetchCommodityLists(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('data: ${snapshot.data}');
          print('connectionState: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('loading...'),
            );
          }
          return ListView(
            children: snapshot.data.map<Widget>((item) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(
                            pageTitle: '商品详情',
                          )));
                },
                title: Text(
                  "商品名:${item.title}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text("商品id:${item.id}\n价格:${item.price}"),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                leading: Image.network(
                  item.imageUrl,
                  height: 200.0,
                  width: 130.0,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
