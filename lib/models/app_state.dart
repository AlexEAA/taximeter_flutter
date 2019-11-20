import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:taximeter/models/orders_model.dart';
import 'package:taximeter/models/profile_model.dart';
import 'package:taximeter/models/rest_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AppState with ChangeNotifier {
  Profile _profile;
  RestService _restService;
  String _driverState = "busy";
  Location _location;
  LocationData _locationData;
  OrdersList _ordersList = new OrdersList();

  var restData;

  AppState() {
    print("### ${this.runtimeType} construcror");
    _restService = new RestService();
    _profile = new Profile(_restService);
    init();
  }

  init() async {
    _location = new Location();

    try{_locationData = await _location.getLocation();}catch (e){}

    _location.onLocationChanged().listen((LocationData currentLocation) {
      if (currentLocation != null){
        _locationData = currentLocation;
        _restService.locationData = _locationData;
      }
    });
  }


  LocationData get locationData => _locationData;

  RestService get restService => _restService;

  Profile get profile => _profile;

  String get driverState => _driverState;


  OrdersList get ordersList => _ordersList;

  parseData(var jsonData){
    print("### AppState parseData");
    _ordersList = OrdersList.fromJson(jsonData);
    notifyListeners();
  }

  getData() async{
    var response = await _restService.httpGet("data");
    parseData(response);
  }


  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showSnackBarError(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
    ));
  }

  hideProgress(BuildContext context) {
    Navigator.pop(context);
  }

  showProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                  //backgroundColor: Colors.yellow,
                  ),
            ));
  }
}
