import 'package:flutter/material.dart';
import 'package:test_door/models/timeline_model.dart';
import 'package:test_door/screens/timeline/components/timeline_Date.dart';
import 'package:test_door/screens/timeline/components/timeline_child.dart';

import '../../../constants.dart';

class TimelineTile extends StatelessWidget {
  final TimelineModel userData;
  final int index;
  final TimelineModel nextUserData;

  const TimelineTile({
    Key key,
    @required this.userData,
    @required this.index,
    this.nextUserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            index == 0 || userData.date != nextUserData.date
                ? Date(
                    size: size,
                    date: userData.date,
                  )
                : SizedBox(
                    height: 0,
                  ),
            userData.command == "OPEN"
                ? TimeLineTileLeftChild(
                    pathPhoto: order_processed,
                    status: userData.command + ' | ' + userData.time,
                    comment: userData.displayName,
                    isFirst: index == 0 ? true : false,
                  )
                : TimeLineTileRightChild(
                    pathPhoto: order_confirmed,
                    status: userData.command + ' | ' + userData.time,
                    comment: userData.displayName,
                    colorDot: Colors.yellowAccent,
                    isFirst: index == 0 ? true : false,
                  ),
          ],
        ),
      ),
    );
  }
}
