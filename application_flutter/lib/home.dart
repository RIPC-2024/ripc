import 'package:flutter/material.dart';
import 'package:ripc_flutter/historyn.dart';
import 'package:ripc_flutter/user_data.dart';
import 'login_control.dart';
import 'features_test.dart';
import 'naver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: settingss(),
    );
  }
}

class settingss extends StatelessWidget {
  String? email = user_data().email;
  String? profile_image_url = user_data().profile_image_url;
  String? user_name = user_data().user_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    ),
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

          SizedBox(
            height: 20,
          ),

          // Tab 1: 교수학습이론
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white, // Background color is white
                border: Border.all(color: Colors.grey, width: 1), // Black border
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: double.infinity,
                    color: Colors.orange, // Colored stripe
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "나의 단속 기여도",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab 2: 정보과학의 이해
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>historyn()));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color is white
                  border: Border.all(color: Colors.grey, width: 1), // Black border
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: double.infinity,
                      color: Colors.green, // Colored stripe
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "단속 내역 조회",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab 3: 코스모스 세미나
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> NaverMapApp(
                    latitude: 37.550317,
                    longitude: 126.925155,
                  )),);
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color is white
                  border: Border.all(color: Colors.grey, width: 1), // Black border
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: double.infinity,
                      color: Colors.blue, // Colored stripe
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "실시간 위치 확인",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab 4: 실험실 안전교육IV[13]
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white, // Background color is white
                border: Border.all(color: Colors.grey, width: 1), // Black border
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: double.infinity,
                    color: Colors.purple, // Colored stripe
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "앱 정보",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
