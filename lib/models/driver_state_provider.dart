import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DriverStateProvider with ChangeNotifier{
  final formatCurrency = new NumberFormat.simpleCurrency();
  String _state;
  String _balance;

  String getTitle(){
    String result = "(" + formatCurrency.format(_balance) + ")";

    return result;
  }

  void set(String state, String balance){
    bool isChange = false;
    if (_state != state){
      _state = state;
      isChange = true;
    }

    if (_balance != balance){
      _balance = balance;
      isChange = true;
    }

    if (isChange){
      notifyListeners();
    }

  }


}