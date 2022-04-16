import 'package:flutter/material.dart';
import 'package:sportistaan/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sportistaan/screens/auth.dart';
import 'package:sportistaan/screens/available.dart';
import 'package:sportistaan/screens/my_matches.dart';
import 'package:sportistaan/services/auth_service.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ,
      appBar: AppBar(
        backgroundColor: const Color(0xFF24243E),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Container(
            decoration: kBoxDecoration,
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Sportistaan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ElevatedButton(onPressed: () async {
      await AuthService.instance.logout();
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()) );
    },child: Text('logout'))
                ],
              ),
            ),
          ),
    );
  }
}
