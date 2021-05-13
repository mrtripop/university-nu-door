import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_door/models/member_model.dart';
import 'package:test_door/screens/account/components/account_card_info.dart';

class CardInfoOperation extends StatelessWidget {
  const CardInfoOperation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final member = Provider.of<List<MemberModel>>(context);
    if (member == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
          itemCount: member.length,
          itemBuilder: (contex, index) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                height: screen.height * 0.25,
                child: CardInfo(
                  member: member[index],
                ));
          });
    }
  }
}
