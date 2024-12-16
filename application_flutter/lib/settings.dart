import 'package:flutter/material.dart';
import 'package:ripc_flutter/user_data.dart';
import 'login_control.dart';
import 'features_test.dart';


class settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String? email = user_data().email;
    String? profile_image_url = user_data().profile_image_url;
    String? user_name = user_data().user_name;



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Color(0xff103C80),
              child: Column(
                children: [
                  Container(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      // Text('$email'),
                      Text('$user_name',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 190,
                      ),
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: Image.network('$profile_image_url'),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      )
                      // ElevatedButton.icon(
                      //   icon: Image.asset(
                      //     'assets/google_logo.png', // Path to your Google logo
                      //     height: 20, // Height for the logo
                      //     width: 20,  // Width for the logo
                      //   ),
                      //   onPressed: (){},
                      //   label: Text('계정 관리'),
                      //
                      //   // style: ElevatedButton.styleFrom(
                      //   //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                      //   // ),
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: Colors.black,
                      //     side: BorderSide(color: Colors.grey),
                      //   ),
                      // )
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),

            Divider(
              color: Colors.grey[400],
            ),
            Expanded(
                child:
                  ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.campaign),
                        title: Text('공지사항'),

                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text('문의하기'),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('개발자 정보'),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: Icon(Icons.assignment),
                        title: Text('이용약관'),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('앱 설정'),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('앱 정보'),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestScreen())
                            );
                          },
                          child: Text('1.0.0',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}