import 'package:flutter/material.dart';
import 'package:ripc_flutter/notifications.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  void initState(){
    FlutterLocalNotification.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'about page',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ElevatedButton(
              onPressed: () => FlutterLocalNotification.showNotification(),
              child: Text('Notification Test'))
        ),
      ),
    );
  }
}
