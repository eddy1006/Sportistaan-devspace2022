import 'package:flutter/material.dart';
import 'package:sportistaan/login_page.dart';
import 'dart:async';

import 'package:sportistaan/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        primaryColor: Colors.white,
      ),
      // home: MainPage(),
      home: MyHomePage(),
    );

    // );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image.asset('assets/images/splash_screen_sp.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset('assets/images/sportistaan_logo_2.png'),
              ),
            ],
          ),
        ));
  }
}
