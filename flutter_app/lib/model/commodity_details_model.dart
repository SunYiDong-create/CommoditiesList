import 'package:flutter/material.dart';
class DetailModel {
  int code;
  String message;
  Data data;

  DetailModel({this.code, this.message, this.data});

  DetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Detail> detail;

  Data({this.detail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int id;
  List<String> imageUrls;
  String title;
  String price;
  List<String> description;

  Detail({this.id, this.imageUrls, this.title, this.price, this.description});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrls = json['image_urls'].cast<String>();
    title = json['title'];
    price = json['price'];
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_urls'] = this.imageUrls;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}