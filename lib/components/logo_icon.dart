import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12.0),
      alignment: Alignment.centerLeft,
      child: Image(
        image: ExactAssetImage("assets/images/1.png"),
        height: 32.0,
        width: 200.0,
      ),
    );
  }
}
