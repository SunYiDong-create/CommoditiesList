import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body: Center(
        child: Text("商城首页"),
      ),
    );
  }

  void getHttp() async {
    Response response;
    response = await Dio().get("http://yapi.mohangtimes.co/mock/29/product_list");
    if (response.statusCode == 200) {
      print(response);
      print("response${response.data}");
    } else {
      print("出错");
    }
  }
}
