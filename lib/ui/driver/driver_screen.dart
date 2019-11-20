import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/app_state.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:taximeter/ui/driver/list_orders_screen.dart';
import 'package:taximeter/ui/driver/map_orders_screen.dart';
import 'package:taximeter/ui/driver/messages_screen.dart';
import 'package:taximeter/ui/widgets/FFNavigationBarItemEx.dart';


class DriverScreen extends StatefulWidget {
  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  var _currentIndex = 1;
  final List<Widget> _screens = [MapOrdersScreen(), ListOrdersScreen("current"), ListOrdersScreen("prior"), MessagesScreen()];

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Consumer<AppState>(builder: (context, state, _) {
            return Text('Занят');
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: appState.getData,
            ),
            IconButton(
              icon: Icon(
                Icons.brightness_1,
                color: Colors.red,
              ),
            ),

          ],
        ),
        drawer: _drawer(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: PageView(
          controller: _controller,
          onPageChanged: (newPage) {
            setState(() {
              this._currentIndex = newPage;
            });
          },
          children: _screens,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (_globalKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
      return Future.value(false);
    } else {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("[10254] Иванов Петр Сидорович"),
            accountEmail: Text("Красная Лада-Приора г.н. к340тр102"),
            currentAccountPicture: CircleAvatar(
              child: Image.asset("assets/images/logo_white.png", fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Text("Баланс"),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Text("23.56"),
          )
        ],
      ),
    );
  }


  Widget _bottomNavigationBar() {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBackgroundColor: Colors.green,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
      ),
      selectedIndex: _currentIndex,
      onSelectTab: (index) {
        this._controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.map,
          label: 'Карта',
        ),
        FFNavigationBarItem(
          iconData: Icons.list,
          label: 'Заказы',
        ),
        FFNavigationBarItem(
          iconData: Icons.line_style,
          label: 'Предвары',
        ),
        FFNavigationBarItemEx(
          iconData: Icons.sms_failed,
          label: 'Сообщения',
          counter: 5,
        ),
      ],
    );
  }
}
