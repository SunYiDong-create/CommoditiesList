import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/commodity_details.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('商品列表'),
        elevation: 0.0,
      ),
      body: HttpDemoHome(),
    );
  }
}

class HttpDemoHome extends StatefulWidget {
  @override
  _HttpDemoHomeState createState() => _HttpDemoHomeState();
}

class _HttpDemoHomeState extends State<HttpDemoHome> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Post>> fetchPosts() async {
    // try {
    final response =
        await http.get('http://yapi.mohangtimes.co/mock/29/product_list');
    // } catch (e) {
    //   print(e);
    // }

    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['data'];
      List<Post> posts = responseBody['products']
          .map<Post>((item) => Post.fromJson(item))
          .toList();

      return posts;
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPosts(),
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
              subtitle: Text("商品id" +
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
    );
  }
}

class Post {
  final int id;
  final String title;
  final String price;
  final String imageUrl;

  Post(
    this.id,
    this.title,
    this.price,
    this.imageUrl,
  );

  Post.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        imageUrl = json['image_url'];

  Map toJson() => {
        'title': title,
      };
}

