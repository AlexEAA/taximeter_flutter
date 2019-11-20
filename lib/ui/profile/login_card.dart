import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/app_state.dart';
import 'package:taximeter/ui/widgets/gradient_button.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> with SingleTickerProviderStateMixin {
  AppState appState;
  Size deviceSize;
  AnimationController controller;
  Animation<double> animation;
  String phoneNumber = '', phoneCode = '';
  String state = 'new';

  Widget _sendState() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onChanged: (phone) => phoneNumber = phone,
                enabled: false,
                style: new TextStyle(fontSize: 15.0, color: Colors.black),
                controller: MaskedTextController(text: phoneNumber, mask: '(000) 000-00-00'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Номер телефона',
                  labelText: 'Номер телефона',
                  icon: Icon(Icons.phone_iphone),
                ),
              ),
              TextFormField(
                onChanged: (code) => phoneCode = code,
                style: new TextStyle(fontSize: 15.0, color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Код подтверждения',
                  labelText: 'Код подтверждения',
                  icon: Icon(Icons.sms),
                ),
              ),
              new SizedBox(
                height: 15.0,
              ),
              GradientButton(
                onPressed: _registration,
                text: 'Вход',
              ),
              new FlatButton(
                child: Text('Получить код повторно'),
                onPressed: () => setState(() {
                  state = 'new';
                  phoneCode = '';
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _newState() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onChanged: (phone) => phoneNumber = phone,
                style: new TextStyle(fontSize: 15.0, color: Colors.black),
                controller: MaskedTextController(text: phoneNumber, mask: '(000) 000-00-00'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Номер телефона',
                  labelText: 'Номер телефона',
                  icon: Icon(Icons.phone_iphone),
                ),
              ),
              new SizedBox(
                height: 15.0,
              ),
              _termsText(),
              new SizedBox(
                height: 15.0,
              ),
              GradientButton(
                onPressed: _login,
                text: 'Получить код',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _termsText() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(style: defaultStyle, children: <TextSpan>[
        TextSpan(text: 'Нажимая кнопку "Получиь код", я соглашаюсь с '),
        TextSpan(
            text: '"Лицензионым соглашением"',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                appState.launchURL("https://taxi-econom.ru/clients.php");
              }),
        TextSpan(text: ', '),
        TextSpan(
            text: '"Пользовательским соглашением"',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                appState.launchURL("https://taxi-econom.ru/clients.php");
              }),
        TextSpan(text: ', а так же с обработкой моей персональной информации на условиях '),
        TextSpan(
            text: '"Политики конфиденциальности"',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                appState.launchURL("https://taxi-econom.ru/clients.php");
              }),
      ]),
    );
  }

  Widget loginCard() {
    return Opacity(
      opacity: animation.value,
      child: SizedBox(
        height: deviceSize.height / 2 - 20,
        width: deviceSize.width * 0.85,
        child: new Card(color: Colors.white, elevation: 2.0, child: state == 'new' ? _newState() : _sendState()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    controller = new AnimationController(vsync: this, duration: new Duration(milliseconds: 1500));
    animation = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    animation.addListener(() => this.setState(() {}));
    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return loginCard();
  }

  _registration() async {
    appState.showProgress(context);
    String result = await appState.profile.registration(phoneCode);
    appState.hideProgress(context);
    print(result);
    if (result == 'OK'){
      Navigator.of(context).pushReplacementNamed('/splash');

    }
    else appState.showSnackBarError(context, result);

  }

  _login() async {
    appState.showProgress(context);
    String result = await appState.profile.login(phoneNumber);
    appState.hideProgress(context);

    if (result == 'OK') {
      setState(() {
        state = 'sended';
      });
    } else
      appState.showSnackBarError(context, result);
  }
}