import 'package:flutter/material.dart';
import 'package:taximeter/app_settings.dart';

import 'arc_clipper.dart';

class MainBackground extends StatelessWidget {
  final showLogo;


  MainBackground({this.showLogo = false});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: AppSettings.kitGradients,
                  )),
            ),
            showLogo
                ? new Center(
              child: SizedBox(
                  height: deviceSize.height / 8,
                  width: deviceSize.width / 2,
                  child: Image.asset("assets/images/logo_white.png", fit: BoxFit.cover)
              ),
            )
                : new Container()


          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );


  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }


}
