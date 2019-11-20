

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taximeter/models/rest_service.dart';

import '../app_settings.dart';

class Profile {
  String _phone;
  String _code;
  String _token;
  RestService _restService;

  Profile(this._restService){
    print("### ${this.runtimeType} construcror");
  }

  free() async {
    await _restService.httpGet("profile/free");
  }

  busy() async {
    await _restService.httpGet("profile/busy");
  }

  logout() async {
    await _restService.httpGet("profile/logout");
  }

  registration(String code) async {
    _code = code;
    var response = await _restService.httpGet("profile/registration?phone=" + _phone + "&code=" + _code);
    if (response == null) return AppSettings.errorServiceUnavailable;
    if (response['status'] == 'OK') {
      _token = response['result'];
      _restService.token = _token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", _token);
      print(_token);
      return 'OK';
    }
    return response['error'];
  }

  login(String phone) async {
    _phone = phone;
    var response = await _restService.httpGet("profile/login?phone=" + _phone);
    if (response == null) return AppSettings.errorServiceUnavailable;
    if (response['status'] == 'OK') return 'OK';
    return response['error'];
  }

  auth() async {
    _restService.init();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    if (_token != '') {
      _restService.token = _token;
      var response = await _restService.httpGet("profile/auth");
      // print('User.Authentication');
      if (response == null) {
        return null;
      }
      if (response['status'] == 'OK') return true;
    }

    return false;
  }
}