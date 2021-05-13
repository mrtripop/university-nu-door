import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/account/components/account_card_info_operation.dart';
import 'package:test_door/services/database.dart';

class BodyAccount extends StatelessWidget {
  const BodyAccount({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserClass user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: DatabaseService(uid: user.uid).userinfo,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return StreamProvider.value(
              value: DatabaseService(uid: data['masterID']).member,
              child: CardInfoOperation(),
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }
}
