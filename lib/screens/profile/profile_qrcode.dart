import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_door/models/user_model.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key key, @required this.user}) : super(key: key);

  final UserClass user;

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: QrImage(
        data: widget.user.uid,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
