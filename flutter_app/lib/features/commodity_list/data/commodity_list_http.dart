import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'commodity_list_model.dart';

//请求商品列表数据
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
    throw Exception('Failed to fetch data.');
  }
}
