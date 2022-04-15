import 'package:flutter/material.dart';
import 'package:sportistaan/constants.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
        child: const Center(
          child: Text(
            'Sportistaan',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
