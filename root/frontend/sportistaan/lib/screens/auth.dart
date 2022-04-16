import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sportistaan/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sportistaan/main_page.dart';
import 'package:sportistaan/screens/available.dart';
import 'package:sportistaan/screens/home.dart';
import 'package:sportistaan/screens/my_matches.dart';
import 'package:sportistaan/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isProgressing = false;

  bool isLoggedIn = false;

  String errorMessage = '';

  String? name;

  @override
  void initState() {
    super.initState();
    initAction();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isProgressing)
            Center(child: CircularProgressIndicator())
          else if (!isLoggedIn)
            Center(
              child: ElevatedButton(
                onPressed: loginAction,
                child: Text('Login | Register'),
              ),
            )
          else
            Text('Welcome $name'),
        ], // <Widget>[]
      ),
    );
  }
    setSuccessAuthState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken?.name;
    });

    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MainPage()));
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
        errorMessage = message;
      });
    }
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }
}