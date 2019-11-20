import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/driver_state_provider.dart';
import 'package:taximeter/ui/driver/driver_screen.dart';
import 'package:taximeter/ui/profile/login_screen.dart';
import 'package:taximeter/ui/splash_screen.dart';

import 'models/app_state.dart';

void main() => runApp(MyApp());
/*{
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AppState(context),
      child: MyApp(),
    ),
  );
}

 */


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => AppState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => DriverStateProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.blueGrey,
            accentColor: Colors.grey
        ),
        routes: <String, WidgetBuilder>{
          "/splash" : (BuildContext context) => SplashScreen(),
          "/login" : (BuildContext context) => LoginScreen(),
          "/driver":(BuildContext context) => DriverScreen(),
        },
        home: SplashScreen(),
      ),
    );
  }
}
