import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color bgcolor;
  final String logoPath;
  final double logoWidth;
  final Color containerColor;
  final EdgeInsets padding;
  final double containerHeight;
  final EdgeInsets containerMargin;
  final Icon iconSetting;
  final Widget iconPopup;

  const Background({
    Key key,
    @required this.child,
    this.bgcolor,
    this.logoPath,
    this.logoWidth,
    this.containerColor,
    this.padding,
    this.containerHeight,
    this.containerMargin,
    this.iconSetting,
    this.iconPopup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: bgcolor != null ? bgcolor : Color(0xff1E8449),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -15,
            left: 120,
            child: Image.asset(
              "assets/images/ellipse.png",
              width: size.width * 0.9,
            ),
          ),
          Positioned(
            top: size.height * 0.14,
            left: size.width * 0.06,
            child: logoPath != null
                ? Image.asset(
                    "$logoPath",
                    width: logoWidth != null ? logoWidth : size.width * 0.8,
                  )
                : Text('Your Logo'),
          ),
          Positioned(
            top: size.height * 0.225,
            child: Container(
              child: child,
              padding: padding,
              height: containerHeight != null ? containerHeight : 513,
              width: size.width,
              margin: containerMargin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: containerColor != null ? containerColor : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
