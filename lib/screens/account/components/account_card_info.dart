import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_door/models/member_model.dart';
import 'dart:math';

import '../../../constants.dart';

class CardInfo extends StatelessWidget {
  final MemberModel member;

  const CardInfo({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _random = new Random();
    final cardColor = cardColorArray[_random.nextInt(cardColorArray.length)];
    Size screen = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
              color: Colors.white54, width: 5, style: BorderStyle.solid)),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: cardColor[0].withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
              ),
              BoxShadow(
                color: cardColor[1].withOpacity(0.1),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: cardColor,
            )),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: screen.width * 0.25, //4 จตุรัส
                  width: screen.width * 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle),
                    margin: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'assets/icons/male_user.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(member.name, style: cardHeaderTextStyle),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          member.email,
                          style: cardDefaultTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Status: ${member.status}',
                          style: cardDefaultTextStyle,
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
