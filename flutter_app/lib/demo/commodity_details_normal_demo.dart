import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/commodity_details_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

bool _isFirst;
const APPBAR_SCROLL_OFFSET = 100;
List<String> imgs = new List();
List<String> description = new List();

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({this.pageTitle});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  void initState() {
    _isFirst = true;
  }

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
          if (snapshot.connectionState == ConnectionState.waiting && _isFirst) {
            return Center(
              child: Text('loading...'),
            );
          }
          return Scaffold(
            body: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 250,
                          child: Swiper(
                            itemCount: imgs.length,
                            autoplay: true,
                            key: UniqueKey(),
                            loop: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                imgs[index],
                                fit: BoxFit.fill,
                              );
                            },
                            pagination: SwiperPagination(),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "商品描述:",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
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
                    ),
                  ),
                ),
                Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(color: Colors.red),
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text('商品详情'),
                        elevation: 0.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
      imgs.clear();
      description.clear();
      imgs.addAll(details.first.imageUrls);
      description.addAll(details.first.description);
      _isFirst = false;
      return details;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }
}
