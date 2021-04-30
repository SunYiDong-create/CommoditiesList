import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//点击效果控件封装
class RippleWidget extends StatelessWidget {
  final Function onTap;
  final Widget child;

  RippleWidget({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: child,

      ///点击颜色
      splashColor: Colors.blue,
      onTap: () {
        ///延迟200ms 效果更明显点
        Future.delayed(Duration(milliseconds: 200), onTap);
      },
    );
  }
}

class RippleWidget2 extends StatelessWidget {
  final Function onTap;

  ///点击事件
  final String title;
  Decoration decoration = BoxDecoration();
  double radius = 0;
  Color splashColor = Colors.blue;
  double height = 40;
  double width = 60;
  Widget child;

  RippleWidget2({
    this.title,
    this.onTap,
    this.decoration,
    this.radius,
    this.splashColor,
    this.height,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: decoration ?? BoxDecoration(),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        splashColor: splashColor,
        child: child,
        onTap: onTap,
      ),
    );
  }
}

class TapWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Material(
        child: Container(
          child: new RippleWidget2(
            child: Container(
              //内部控件
              width: 300,
              height: 50,
              child: Center(child: Text("嵌套中的控件")),
            ),
            title: "  tap2:封装可修改水波颜色、宽高、水波半径的点击按钮  ", //本身点击效果控件属性设置
            onTap: () {},
            radius: 5.0,
            splashColor: Colors.blue,
            width: 350.0,
            height: 50.0,
          ),
        ),
      ),
    ));
  }
}
