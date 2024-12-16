import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapApp extends StatelessWidget {
  final double latitude;
  final double longitude;
  const NaverMapApp({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NaverMapScreen(latitude: latitude, longitude: longitude),
    );
  }
}

class NaverMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const NaverMapScreen({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  _NaverMapScreenState createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await NaverMapSdk.instance.initialize(clientId: '');
      setState(() {
        isInitialized = true;
      });
    } catch (e) {
      print("Error initializing NaverMap SDK: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading Map...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("네이버 지도"),
        centerTitle: true,
      ),
      body: NaverMap(
        options: NaverMapViewOptions(
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
          initialCameraPosition: NCameraPosition( // 지도 처음 위치
            target: NLatLng(widget.latitude, widget.longitude),
            zoom: 15,
            bearing: 0,
            tilt: 0
          ),
        ),
        onMapReady: (controller) {
          print("Naver Map Loaded");
          final marker = NMarker(
              id: 'Marker 1',
              position: NLatLng(widget.latitude, widget.longitude));
          controller.addOverlay(marker);
        },
      ),
    );
  }
}
