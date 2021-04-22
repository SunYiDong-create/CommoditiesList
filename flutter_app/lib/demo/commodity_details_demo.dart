import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../model/commodity_details_model.dart';

class DetailsPage extends StatelessWidget {
  List<String> imgs = new List();
  List<String> description = new List();
  final String pageTitle;
  DetailsPage({this.pageTitle});
  Widget _listItemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Image.network(
            imgs[index],
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDetailsPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('data: ${snapshot.data}');
          print('connectionState: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('loading...'),
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(pageTitle),
                elevation: 0.0,
              ),
              body: Column(
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
                      pagination: new SwiperPagination(), //如果不填则不显示指示点
                      autoplay: true, //如果不填则不显示左右按钮
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: imgs.length,
                      itemBuilder: _listItemBuilder,
                    )
                    ),
                  )
                ],
              )
          );
        });
  }

  Future<List<String>> fetchDetailsPosts() async {
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
      return imgs;
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }

}
