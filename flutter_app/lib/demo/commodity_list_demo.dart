import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/commodity_list_model.dart';
import 'package:http/http.dart' as http;

import 'commodity_details_demo.dart';

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

class CommodityListHome extends StatefulWidget {
  @override
  _CommodityListHomeState createState() => _CommodityListHomeState();
}

class _CommodityListHomeState extends State<CommodityListHome> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<CommodityList>> fetchCommodityLists() async {
    final response =
        await http.get('http://yapi.mohangtimes.co/mock/29/product_list');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['data'];
      List<CommodityList> commodityLists = responseBody['products']
          .map<CommodityList>((item) => CommodityList.fromJson(item))
          .toList();
      return commodityLists;
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 下拉刷新方法,为list重新赋值
     */
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
                      builder: (BuildContext context) => DetailsPage(
                            pageTitle: '商品详情',
                          )));
                },
                title: Text(
                  "商品名：" + item.title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text("商品id:" +
                    item.id.toString() +
                    "\n" +
                    "价格：" +
                    item.price.toString()),
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
