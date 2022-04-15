import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({Key? key}) : super(key: key);

  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  late IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io('https://sportistaan.herokuapp.com/');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('message', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('close', (_) => print(_));
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff24243E),
      extendBody: true,
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
          'Chatroom',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: kBoxDecoration,
              //eight: MediaQuery.of(context).size.height * 0.71,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                print(value);
              },
              decoration: InputDecoration(
                hintText: "Say Hi! to everyone",
                hintStyle: TextStyle(color: Colors.white70),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
