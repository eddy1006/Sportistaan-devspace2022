import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportistaan/widgets/round_icon_button.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String eventName = '', venue = '', date = '', time = '', gender = 'Male';
  int numberOfPlayers = 2;
  TimeOfDay selectedTime = TimeOfDay.now();
  postData() async {
    try {
      var response = await http.post(
        Uri.parse("https://sportistaan.herokuapp.com/create-event"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          "gameName": eventName,
          "time": time,
          "venue": venue,
          "student_info": [
            {"name": "person4"},
            {"name": "person3"}
          ],
          "finish": false,
          "winner": ""
        }),
      );
      print(response.statusCode);
      print(response.body);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create an Event',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
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
      backgroundColor: Color(0xFF0F0C29),
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Genral Information',
            style: kLabelTextStyle,
          ),
          TextField(
            onChanged: (value) {
              eventName = value;
            },
            maxLength: 50,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              labelText: 'Event Name',
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFC833), width: 2.0),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          TextField(
            onChanged: (value) {
              venue = value;
            },
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              labelText: 'Venue',
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFC833), width: 2.0),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today_rounded),
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 11, 21),
                  lastDate: DateTime(2021, 12),
                  builder: (context, picker) {
                    return Theme(
                      //TODO: change colors
                      data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Color(0xff24243E),
                          onPrimary: Color(0xFFFFC833),
                          surface: Color(0xFF0F0C29),
                          onSurface: Colors.white,
                        ),
                        dialogBackgroundColor: Colors.blueGrey[700],
                      ),
                      child: picker!,
                    );
                  }).then((selectedDate) {
                if (selectedDate != null) {
                  date = selectedDate.toString();
                  print(date);
                }
              });
            },
            label: Text('Show Date Picker'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                  time = selectedTime.toString();
                },
                child: Text("Choose Time"),
              ),
              SizedBox(width: 15),
              Text("${selectedTime.hour}:${selectedTime.minute}",
                  style: kLabelTextStyle),
            ],
          ),
          Column(
            children: [
              Text(
                'Number of Players',
                style: kLabelTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundIconButton(
                    icon: Icons.remove,
                    onPressed: () {
                      setState(() {
                        numberOfPlayers--;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    numberOfPlayers.toString(),
                    style: kLabelTextStyle.copyWith(fontSize: 27),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RoundIconButton(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        numberOfPlayers++;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          Text(
            'Preffered gender',
            style: kLabelTextStyle,
          ),
          DropdownButton(
            value: gender,
            style: const TextStyle(
              color: Color(0xFFFFC833),
            ),
            items: <String>['Anyone', 'Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                gender = newValue!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              postData();
            },
            child: Text(
              'Create',
              style: kLabelTextStyle,
            ),
            style: ElevatedButton.styleFrom(),
          ),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
