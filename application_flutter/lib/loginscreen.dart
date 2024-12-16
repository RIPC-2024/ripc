import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ripc_flutter/mainscreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'login_control.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Screen",
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('R I P C',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text('실시간 불법 주정차 단속 시스템',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage("assets/univ_image.png"),
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 32,
              ),
              SignInButton(

                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () async {
                  await loginProcess();
                  askforpermission();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mainscreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void askforpermission() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
    print(statuses[Permission.notification]);
  }
}