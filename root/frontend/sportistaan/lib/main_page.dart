import 'package:flutter/material.dart';
import 'package:sportistaan/screens/available.dart';
import 'package:sportistaan/screens/chatroom.dart';
import 'package:sportistaan/screens/home.dart';
import 'package:sportistaan/screens/my_matches.dart';
import 'package:sportistaan/screens/request.dart';
import 'package:svg_icon/svg_icon.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(),
    RequestPage(),
    AvailablePage(),
    MyMatches(),
    ChatroomPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor:const  Color(0xFF0F0C29),
        selectedItemColor: const Color(0xFFFFC833),
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home,size: 28,),
          ),
          BottomNavigationBarItem(
            label: 'Request',
            icon: SvgIcon('assets/icons/post.svg'),
            ),
          BottomNavigationBarItem(
            label: 'Available',
            icon: SvgIcon('assets/icons/matches.svg'),
            ),
          BottomNavigationBarItem(
            label: 'Matches',
            icon: SvgIcon('assets/icons/schedule.svg',),
            activeIcon: Icon(Icons.watch_later),
          ),
          BottomNavigationBarItem(
            label: 'Chatroom',
            icon: Icon(Icons.question_answer_outlined),
            activeIcon: SvgIcon('assets/icons/chatroom.svg'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
