import 'package:flutter/material.dart';
import 'package:test_door/main_component/OutlineButtonTemplate.dart';

import '../../../constants.dart';

class CardFeatureDetail extends StatelessWidget {
  final String featureName;
  final String status;
  final Widget child;
  final Size size;
  final Color buttonColor;
  final Function onPressed;

  const CardFeatureDetail({
    Key key,
    this.size,
    this.featureName,
    this.status,
    this.child,
    this.buttonColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.2,
      child: Card(
          shadowColor: appBarBGcolor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
              side: BorderSide(
                color: Colors.white,
                width: 5,
                style: BorderStyle.solid,
              )),
          elevation: 4,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  featureName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        )
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  status,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        )
                      ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    child: OutlinedButtonTemplate(
                      child: child,
                      onPressed: onPressed,
                      colorBG: buttonColor != null ? buttonColor : Colors.white,
                      colorShadow: appBarBGcolor.withOpacity(0.3),
                      sideWidth: 1,
                      sideColor: appBarBGcolor.withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(5),
          )),
    );
  }
}
