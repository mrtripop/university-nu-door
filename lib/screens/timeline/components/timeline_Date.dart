import 'package:flutter/material.dart';

import '../../../constants.dart';

class Date extends StatelessWidget {
  final String date;
  const Date({
    Key key,
    @required this.size,
    this.date,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(36)),
          color: appBarBGcolor,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 3)),
      margin: EdgeInsets.all(20),
      child: Center(
          child: Text(
        date,
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      )),
    );
  }
}
