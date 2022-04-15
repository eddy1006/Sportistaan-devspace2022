
import 'package:flutter/material.dart';
import '../models/events.dart';

class MatchCard extends StatelessWidget {
  final Events event;

  MatchCard(this.event);

  @override
  Widget build(BuildContext context) {
    final eventName = event.gameName;
    final eventTime = event.time;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [Icon(Icons.group), Text('Participants number')],
                ),
                Row(
                  children: [
                    Icon(Icons.location_city),
                    Text(event.venue),
                  ],
                )
              ],
            ),
            Text(
              '$eventName \n $eventTime',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            ElevatedButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.delete),
                label: Text('Delete'))
          ],
        ),
      ),
    );
  }
}
