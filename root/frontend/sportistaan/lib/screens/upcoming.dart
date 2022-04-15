import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sportistaan/constants.dart';
import '../widgets/upcoming_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/events.dart';

class Upcoming extends StatefulWidget {
  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Events> eventList = [];

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://sportistaan.herokuapp.com/show-event'));

    final extractedData = json.decode(response.body) as List<dynamic>;
    extractedData.forEach((element) {
      final event = Events(
          id: element['_id'],
          gameName: element['gameName'],
          time: element['time'],
          venue: element['venue']);
      eventList.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration: kBoxDecoration,
                child: ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    return UpcomingCard(eventList[index]);
                  },
                ));
          } else if (snapshot.hasError) {
            throw Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
