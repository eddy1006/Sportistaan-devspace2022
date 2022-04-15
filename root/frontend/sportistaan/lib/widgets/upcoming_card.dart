import 'package:flutter/material.dart';
import '../models/events.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpcomingCard extends StatelessWidget {
  Events event;

  UpcomingCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color(0xff4AC29A), Color(0xffBDFFF3)]),
        ),
        child: Column(
          children: [
            Text(
              event.gameName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(event.time),
                Text(event.venue),
                Text('Gender'),
              ],
            ),
            TextButton(
                onPressed: () async {
                  try {
                    var response = await http.post(
                      Uri.parse(
                          "https://sportistaan.herokuapp.com/join-event"),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, Object>{
                        "_id": event.id,
                        "name": "name",
                      }),
                    );
                    print(response.statusCode);
                    print(response.body);
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
