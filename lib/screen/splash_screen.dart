import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:streamer/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var image = Image.asset('assets/images/logo.png');
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppStyles.primaryColorGray,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    width: double.maxFinite,
                    child: Center(
                      child: image,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'With ',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.blue,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GradientText(
                    'KTV Streamer',
                    gradient: LinearGradient(colors: [
                      Colors.lightBlueAccent,
                      Colors.blue,
                      Colors.indigo
                    ]),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
