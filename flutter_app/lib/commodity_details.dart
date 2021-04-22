import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//banner轮播图片组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['imageUrl']}",fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
class DetailsPage extends StatelessWidget {
  final String pageTitle;

  DetailsPage({this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: fetchDetailsPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['detail'] as List).cast();
            return Column(
              children: <Widget>[SwiperDiy(swiperDataList: swiper)],
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }

  Future<List<Details>> fetchDetailsPosts() async {
    final response =
    await http.get('http://yapi.mohangtimes.co/mock/29/product_detail');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['data'];
      List<Details> details = responseBody['detail']
          .map<Details>((item) => Details.fromJson(item))
          .toList();

      return details;
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }
}

class Details {
  final int id;
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  Details(this.id, this.title, this.price, this.imageUrl, this.description);

  Details.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        description = json['description'],
        imageUrl = json['image_urls'];

  Map toJson() => {
    'title': title,
  };
}
