import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/app_state.dart';
import 'package:taximeter/ui/widgets/main_background.dart';

import '../app_settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print("### _SplashScreenState initState");
    _auth();
  }

  _auth() async {
    return Timer(
        Duration(seconds: 1), () async {
      final appState = Provider.of<AppState>(context, listen: false);
      var auth = await appState.profile.auth();
      if (auth == null) {
        final snackBar = SnackBar(
          content: Text(AppSettings.errorServiceUnavailable),
          duration: Duration(minutes: 10),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
          ),

        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
      else {
        if (auth)Navigator.of(context).pushReplacementNamed('/driver');
        else Navigator.of(context).pushReplacementNamed('/login');

      }

    }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffeeeeee),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MainBackground(
            showLogo: true,
          ),
          new Positioned(
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: LinearProgressIndicator(),
                )
            ),
          ),
        ],
      ),
    );
  }


}
