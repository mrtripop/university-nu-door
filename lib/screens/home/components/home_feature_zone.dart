import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_door/screens/home/components/home_card_feature_detail.dart';

import '../../../constants.dart';

class FeatureZone extends StatelessWidget {
  final bool tapUnlock;
  final bool tapAssist;
  final String unlockState;
  final String assistState;
  final Size size;
  final Function onPressedLeft;
  final Function onPressedRight;

  FeatureZone({
    this.size,
    this.assistState,
    this.tapAssist,
    this.tapUnlock,
    this.unlockState,
    this.onPressedLeft,
    this.onPressedRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 20 + kDefaultPadding, 0, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36), topRight: Radius.circular(36)),
            color: Color(0xff3399ff)),
        child: Column(children: [
          Text(
            'Feature',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CardFeatureDetail(
                      size: size,
                      featureName: 'UNLOCK DOOR',
                      status: 'Status: $unlockState',
                      child: tapUnlock
                          ? SvgPicture.asset(
                              'assets/icons/shutdown_turn_on_icon.svg',
                              width: 40,
                            )
                          : SvgPicture.asset(
                              'assets/icons/shutdown_turn_off_icon.svg',
                              width: 40,
                            ),
                      onPressed: onPressedLeft,
                    ),
                  ),
                  Expanded(
                    child: CardFeatureDetail(
                      size: size,
                      featureName: 'ASSISTANT',
                      status: 'Status: $assistState',
                      child: tapAssist
                          ? SvgPicture.asset(
                              'assets/icons/shutdown_turn_on_icon.svg',
                              width: 40,
                            )
                          : SvgPicture.asset(
                              'assets/icons/shutdown_turn_off_icon.svg',
                              width: 40,
                            ),
                      onPressed: onPressedRight,
                    ),
                  )
                ],
              ))
        ]));
  }
}
