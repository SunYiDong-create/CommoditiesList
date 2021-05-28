import 'package:flutter/material.dart';

Widget TapWidget52() {
  return new Material(
    child: new Ink(
      child: new InkWell(
        onTap: () {
          print("图片点击事件");
        },
        child: new Container(
          height: 200,
          //设置child 居中
          alignment: Alignment(0, 0),
          child: Ink.image(
            image: AssetImage(
              "assets/images/sasuke.jpg",
            ),
            height: 300,
            width: 300,
          ),
        ),
      ),
    ),
  );
}
