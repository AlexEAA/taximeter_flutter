import 'package:flutter/material.dart';
import 'package:taximeter/models/orders_model.dart';

class ListOrderItem extends StatelessWidget {
  final OrderItem orderItem;


  ListOrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(orderItem.distance.toString()),
      subtitle: Text(orderItem.dispatcherName),
    );
  }
}
