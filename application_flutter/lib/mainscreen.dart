import 'package:flutter/material.dart';

import 'home.dart';
import 'history.dart';
import 'settingss.dart';
import 'historyn.dart';
import 'settings.dart';

void main() {
  runApp(const mainscreen());
}


class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreen();
}

class _mainscreen extends State<mainscreen> {

  int _currentIndex=0;
  List<Widget> body = [
    settingss(),
  ];

  @override
  Widget build(BuildContext context) {

    // add stateful widget to body list
    body.insert(1, historyn());
    body.insert(2, settings());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RIPC_Flutter",
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
          )
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: body[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            )
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            iconSize: 30,
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: '홈',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: '단속내역',
                icon: Icon(Icons.list_alt_outlined),
              ),
              BottomNavigationBarItem(
                label: '더보기',
                icon: Icon(Icons.more_horiz),
              ),
            ],
            unselectedItemColor: Colors.black,
            selectedItemColor: Color(0xff103C80),
            ),
        )
      ),
    );
  }
}