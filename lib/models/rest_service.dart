import 'dart:convert';
import 'dart:io';

import 'package:device_id/device_id.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:taximeter/app_settings.dart';
import 'package:taximeter/models/app_state.dart';


class RestService{
  int _curRestIndex = 0;
  String _token = '';
  String _deviceId;
  LocationData _locationData;


  RestService(){
    print("### ${this.runtimeType} construcror");
  }

  set token(String value) {
    _token = value;
  }

  init() async {
    if (_deviceId == null){
      _deviceId = await DeviceId.getID;
    }
  }


  set locationData(LocationData value) {
    _locationData = value;
  }

  Future<dynamic> httpGet(path) async{
    print("httpGet $path");
    var result;
    http.Response response;
    //print("httpGet start $path");
    String url = AppSettings.restHost[_curRestIndex] + path;
    response = await _httpGetH(url);
    if (response == null){
      for (var host in AppSettings.restHost){
        if ((response == null) & (AppSettings.restHost.indexOf(host) != _curRestIndex)){
          url = host + path;
          // print(url);
          response = await _httpGetH(url);
          if (response != null){
            _curRestIndex = AppSettings.restHost.indexOf(host);
          }
        }
      } // for (var host in AppSettings.restHost){
    } // if (response == null){

    // print(response.body);
    //print("httpGet _curRestIndex = $_curRestIndex");
    //print("httpGet stop $path");
    if (response != null){
      if (response.statusCode == 200){
        result = json.decode(response.body);
        //_appState.parseData(result);
      }
    }
    print("httpGet result = $result");
    return result;
  }

  Future<http.Response> _httpGetH(url) async{
    // print('httpGet path = $url');
    http.Response response;
    try{
      response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + authHeader()},);
    }
    catch (e){print(e.toString());}

    return response;
  }

  String authHeader() {

    var header = {
      "token":_token,
      "device_id": _deviceId
    };
    if (_locationData != null){
      header.addAll({
        "lt": _locationData.latitude.toString(),
        "ln": _locationData.longitude.toString(),
      });

    }


    //print(header);
    var bytes = utf8.encode(header.toString());
    //print(base64.encode(bytes));
    return base64.encode(bytes);
  }

}