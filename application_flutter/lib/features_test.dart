import 'package:flutter/material.dart';
import 'package:ripc_flutter/loginscreen.dart';
import 'login_control.dart';
import 'gps.dart';
import 'notifications.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test"),),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400,
            ),
            OutlinedButton(
                onPressed: () {
                  FlutterLocalNotification.showNotification();
                },
                child: Text("Notification",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
            ),
            OutlinedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationScreen())
                  );
                },
                child: Text('GPS',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
            ),
            OutlinedButton.icon(
              icon: Icon(Icons.logout),
                onPressed: (){
                  LoginAPI.logOut;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => loginscreen(),
                      ),
                  );
                },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              label: Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
