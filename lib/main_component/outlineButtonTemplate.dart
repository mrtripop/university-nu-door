import 'package:flutter/material.dart';

import '../constants.dart';

class OutlinedButtonTemplate extends StatelessWidget {
  final Widget child;
  final Color colorBG;
  final Color colorShadow;
  final Size size;
  final double circle;
  final double elevation;
  final double sideWidth;
  final Color sideColor;
  final Color foregroundColor;
  final Function onPressed;
  final Color colorText;
  final double fontSize;
  final FontWeight fontWeight;

  const OutlinedButtonTemplate({
    Key key,
    this.circle,
    this.colorBG,
    this.colorShadow,
    this.elevation,
    this.foregroundColor,
    this.onPressed,
    this.sideColor,
    this.sideWidth,
    this.size,
    this.child,
    this.colorText,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              colorBG != null ? colorBG : Colors.white),
          side: MaterialStateProperty.all(BorderSide(
              width: sideWidth != null ? sideWidth : 1,
              color:
                  sideColor != null ? sideColor : Colors.blue.withOpacity(0.2),
              style: BorderStyle.solid)),
          minimumSize:
              MaterialStateProperty.all(size != null ? size : Size(150, 50)),
          shadowColor: MaterialStateProperty.all(colorShadow != null
              ? colorShadow
              : appBarBGcolor.withOpacity(0.2)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circle != null ? circle : 24),
          )),
          foregroundColor: MaterialStateProperty.all(
              foregroundColor != null ? foregroundColor : Colors.white),
          elevation:
              MaterialStateProperty.all(elevation != null ? elevation : 5.0),
        ),
        onPressed: onPressed);
  }
}
