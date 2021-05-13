import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_door/models/timeline_model.dart';
import 'package:test_door/screens/timeline/components/timeline_tile.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<List<TimelineModel>>(context);
    if (userData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: userData.length,
        itemBuilder: (contex, index) {
          return TimelineTile(
            userData: userData[index],
            index: index,
            nextUserData: index != 0 && index < userData.length
                ? userData[index - 1]
                : userData[index],
          );
        },
      );
    }
  }
}
