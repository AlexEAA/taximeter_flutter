class OrdersList{
  List<OrderItem> curOrders = [];
  List<OrderItem> priorOrders = [];
  List<OrderItem> hisOrders = [];


  OrdersList({this.curOrders, this.priorOrders, this.hisOrders});

  factory OrdersList.fromJson(Map<String,dynamic> json) {
    List<OrderItem> curOrders = [];
    List<OrderItem> priorOrders = [];
    List<OrderItem> hisOrders = [];
    print(json);
    if (json.containsKey('result')){
      var result = json['result'];
      if (result.containsKey('orders')){
        Iterable list = result['orders'];
        curOrders = list.map((model) => OrderItem.fromJson(model)).toList();
      }
      if (result.containsKey('prior_orders')){
        Iterable list = result['prior_orders'];
        priorOrders = list.map((model) => OrderItem.fromJson(model)).toList();
      }
    }


    return OrdersList(curOrders: curOrders, priorOrders: priorOrders, hisOrders: hisOrders);
  }
}


class OrderItem{
  final String distance;
  final String payType;
  final String dispatcherPay;
  final String cost;

  final String dispatcherName;


  OrderItem({this.distance, this.payType, this.dispatcherPay, this.cost, this.dispatcherName});

  factory OrderItem.fromJson(Map<String,dynamic> json) {
    return OrderItem(
      distance: json['dist'],
      payType: json['pay'],
      dispatcherPay: json['disp_pay'],
      cost: json['cost'],
      dispatcherName: json['disp'],
    );
  }



}