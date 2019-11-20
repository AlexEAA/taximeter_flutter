import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/app_state.dart';
import 'package:taximeter/ui/driver/widgets/list_order_item.dart';

class ListOrdersScreen extends StatefulWidget {
  String _listType;

  ListOrdersScreen(this._listType);

  @override
  _ListOrdersScreenState createState() => _ListOrdersScreenState(_listType);
}

class _ListOrdersScreenState extends State<ListOrdersScreen> {
  String _listType;

  _ListOrdersScreenState(this._listType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AppState>(builder: (context, appState, child) {
        if (_listType == "current") {
          if (appState.ordersList.curOrders != null) {
            print(appState.ordersList.curOrders.length);
            return ListView.builder(
              itemCount: appState.ordersList.curOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return ListOrderItem(appState.ordersList.curOrders[index]);
              },
            );
          }
          return Container();
        } else if (_listType == "prior") {
          if (appState.ordersList.priorOrders != null) {
            print(appState.ordersList.priorOrders.length);
            return ListView.builder(
              itemCount: appState.ordersList.priorOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return ListOrderItem(appState.ordersList.priorOrders[index]);
              },
            );
          }
          return Container();
        } else {
          return Container();
        }
      }),
    );
  }
}
