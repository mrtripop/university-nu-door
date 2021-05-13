import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_door/models/timeline_model.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/timeline/components/timeline_operator.dart';
import 'package:test_door/services/database.dart';

class TimelineScreen extends StatelessWidget {
  final UserClass user;
  const TimelineScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('home').doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return StreamProvider<List<TimelineModel>>.value(
              value: DatabaseService(uid: data['masterID']).userTimeline,
              child: Scaffold(
                body: TimeLine(),
              ),
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }
}
