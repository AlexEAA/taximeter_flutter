import 'package:flutter/material.dart';
import 'package:taximeter/ui/widgets/main_background.dart';

import 'login_card.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MainBackground(showLogo: true,),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  LoginCard()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}