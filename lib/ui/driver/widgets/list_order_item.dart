import 'package:flutter/material.dart';
import 'package:taximeter/models/orders_model.dart';

class ListOrderItem extends StatelessWidget {
  final OrderItem orderItem;
  final double fontSize = 20.0;



  ListOrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("~${orderItem.distance} км.", style: TextStyle(fontSize: fontSize),),
                    Text(orderItem.payType, style: TextStyle(fontSize: fontSize),),
                    Text(orderItem.dispatcherPay, style: TextStyle(fontSize: fontSize),),
                    Text(orderItem.cost + " " + String.fromCharCode(0x20BD), style: TextStyle(fontSize: fontSize),)
                  ],
                ),
              ),
            ),
            Divider(height: 1,),
            Row(
              children: <Widget>[
                Text(orderItem.dispatcherName, style: TextStyle(fontSize: fontSize),)
              ],
            )
          ],
        ),

    );
    /*
    return ListTile(
      title: Text(orderItem.distance.toString()),
      subtitle: Text(orderItem.dispatcherName),
    );

     */
  }
}
