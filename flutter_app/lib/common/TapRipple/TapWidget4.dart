import 'package:flutter/material.dart';

class RippleWidget4 extends StatefulWidget {
  final Widget child;
  final Function onTap;

  const RippleWidget4({Key key, this.child, this.onTap}) : super(key: key);

  @override
  ImageTapWidgetState createState() {
    return new ImageTapWidgetState();
  }
}

class ImageTapWidgetState extends State<RippleWidget4> with SingleTickerProviderStateMixin {
  AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _ctl.stop();
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: _ctl,
        builder: (BuildContext context, Widget child) {
          return Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5 * _ctl.value),
            ),
            child: widget.child,
          );
        },
      ),
      onTap: widget.onTap,
      onTapDown: (d) => _ctl.forward(),
      onTapUp: (d) => prepareToIdle(),
      onTapCancel: () => prepareToIdle(),
    );
  }

  void prepareToIdle() {
    AnimationStatusListener listener;
    listener = (AnimationStatus statue) {
      if (statue == AnimationStatus.completed) {
        _ctl.removeStatusListener(listener);
        toStart();
      }
    };
    _ctl.addStatusListener(listener);
    if (!_ctl.isAnimating) {
      _ctl.removeStatusListener(listener);
      toStart();
    }
  }

  void toStart() {
    _ctl.stop();
    _ctl.reverse();
  }
}

class TapWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Material(
        child: Container(
          child: RippleWidget4(
              onTap: () {},
              child: Image.network(
                "https://b-ssl.duitang.com/uploads/item/201402/14/20140214195256_Akuud.thumb.700_0.jpeg",
                height: 300,
                width: 300,
              )),
        ),
      ),
    ));
  }
}
