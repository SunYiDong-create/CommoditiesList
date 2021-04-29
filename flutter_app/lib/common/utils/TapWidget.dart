import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialTapWidget extends StatelessWidget {
  final double radius;
  final Function onTap;
  final Widget child;
  final double elevation;
  final Color backgroundColor;
  final Color splashColor;
  final Function onLongTap;

  const MaterialTapWidget({
    Key key,
    this.radius = 0.0,
    this.onTap,
    this.onLongTap,
    @required this.child,
    this.splashColor,
    this.elevation = 0.0,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        elevation: 0.0,
        child: InkWell(
          child: child,
          onTap: onTap,
          onLongPress: onLongTap,
        ),
      ),
    );

    if (this.splashColor != null) {
      return Theme(
        data: Theme.of(context).copyWith(splashColor: this.splashColor),
        child: w,
      );
    }

    return w;
  }
}
