import 'package:flutter/material.dart';
import 'package:test_door/main_component/outlineButtonTemplate.dart';

class QRscan extends StatelessWidget {
  final Function onPressed;
  QRscan({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButtonTemplate(
      colorBG: Color(0xffFB7344),
      size: Size(150, 50),
      child: Text('QR Scane'),
      onPressed: onPressed,
    );
  }
}
