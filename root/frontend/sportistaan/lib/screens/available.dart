import 'package:flutter/material.dart';
import 'package:sportistaan/screens/upcoming.dart';

class AvailablePage extends StatefulWidget {
  const AvailablePage({Key? key}) : super(key: key);

  @override
  _AvailablePageState createState() => _AvailablePageState();
}

class _AvailablePageState extends State<AvailablePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Upcoming Events",
              ),
              Tab(
                text: "Past Events",
              ),
            ],
          ),
          title: const Text(
            'Available Events',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Upcoming(),
            Icon(Icons.directions_transit, size: 350),
          ],
        ),
      ),
    );
  }
}
