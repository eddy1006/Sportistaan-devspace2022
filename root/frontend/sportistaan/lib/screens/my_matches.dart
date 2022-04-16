import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/match_card.dart';
import '../models/events.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMatches extends StatefulWidget {
  const MyMatches({Key? key}) : super(key: key);

  @override
  _MyMatchesState createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
  List<Events> eventList = [];
  final username = "name";

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sportistaan.herokuapp.com/registered-event?username=$username'));

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
            return Scaffold(
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
                  title: const Text(
                    'My Matches',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                body: Container(
                    decoration: kBoxDecoration,
                    child: ListView.builder(
                        itemCount: eventList.length,
                        itemBuilder: (context, index) {
                          return MatchCard(eventList[index]);
                        })));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
