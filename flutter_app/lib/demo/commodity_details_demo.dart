import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

import '../model/commodity_details_model.dart';

//详情页面banner和列表模块
class DetailsPage extends StatefulWidget {
  final String pageTitle;

  DetailsPage({this.pageTitle});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<String> imgs = new List();

  List<String> description = new List();

  Widget _listItemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.only(bottom: 8.0),
      child: Container(
        child: Image.network(
          description[index],
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchCommodityDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('data: ${snapshot.data}');
          print('connectionState: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('loading...'),
            );
          }
          return Column(
            children: <Widget>[
              Container(
                height: 250,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      imgs[index],
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: imgs.length,
                  pagination: new SwiperPagination(),
                  autoplay: true,
                ),
              ),
              Container(
                child: Text(
                  "商品描述：",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 1250,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: description.length,
                  itemBuilder: _listItemBuilder,
                ),
              )
            ],
          );
        });
  }

  Future<List<Detail>> fetchCommodityDetails() async {
    final response =
        await http.get('http://yapi.mohangtimes.co/mock/29/product_detail');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['data'];
      List<Detail> details = responseBody['detail']
          .map<Detail>((item) => Detail.fromJson(item))
          .toList();
      imgs.addAll(details.first.imageUrls);
      description.addAll(details.first.description);
      return details;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }
}
