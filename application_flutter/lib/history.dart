import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'naver.dart';


class historyn extends StatefulWidget {
  // const ({super.key});

  @override
  State<historyn> createState() => _historyState();
}

class _historyState extends State<historyn> {

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  final _reportSearchStatus = ['전체', '진행중', '취하', '답변완료'];
  final _searchType = ['주소', '차량번호'];
  String selectedReportStatus = "";
  String selectedSearchType = "";

  final int itemCount = 0;


  @override
  void initState(){
    super.initState();
    _startDateController.text = DateTime.now().subtract(const Duration(days: 30)).toString().split(" ")[0];
    _endDateController.text = DateTime.now().toString().split(" ")[0];

    selectedReportStatus = _reportSearchStatus[0];
    selectedSearchType = _searchType[0];
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [

            Container(
              color: Color(0xff103C80),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey,),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "검색",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            )
                        ),
                        IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.clear, color: Colors.grey,)
                        ),
                        Icon(Icons.filter_alt, color: Colors.blue,)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),




            Expanded(
                child: FutureBuilder(
                    future: loadCSV(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        final items = snapshot.data!;
                        return Scrollbar(
                          thickness: 10,
                          interactive: true,
                          thumbVisibility: true,
                          radius: Radius.circular(10),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: items.map((item) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      backgroundColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius: BorderRadius.circular(20),
                                                              child: Container(
                                                                height: 400,
                                                                width: 400,
                                                                child: Image(
                                                                  image: AssetImage(item['image_path']!),
                                                                  fit: BoxFit.cover,
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return const Icon(Icons.error); // Fallback icon
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Image(
                                                image: AssetImage(item['image_path']!),
                                                width: 110,
                                                height: 110,
                                                errorBuilder: (context, error, stackTrace) {
                                                  print('Loading image from: ${item['image_path']}');
                                                  print('Error loading image: ${item['image_path']}');
                                                  return const Icon(Icons.error); // Fallback icon
                                                },
                                              ),
                                            ),


                                            SizedBox(width: 30),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('시간: ${item['report_time']}'),
                                                Text('차량 번호: ${item['vehicle_number']}'),
                                                Row(
                                                  children: [
                                                    Text('위치: ${item['report_location']}'),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) => NaverMapApp(
                                                              latitude: item['latitude'],
                                                              longitude: item['longitude'],
                                                            )
                                                        );
                                                      },
                                                      child: Image(
                                                        image: AssetImage('assets/navermap_image.jpg'),
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text('상태: ${item['report_status']}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );


                      } else
                      {
                        return Center(
                          child: Text('No Data Found :/'),
                        );
                      }
                    }
                )
            ),
          ]
      ),
    );
  }

  Future<void> _selectStartDate() async{
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if (_picked != null){
      setState(() {
        _startDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectEndDate() async{
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if (_picked != null){
      setState(() {
        _endDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

}

Future<List<Map<String, dynamic>>> loadCSV() async {
  try {
    final String data = await rootBundle.loadString('assets/data.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(data);

    // Convert the CSV data into a list of maps
    List<Map<String, dynamic>> items = [];
    for (var i = 1; i < csvTable.length; i++) {
      print("Row $i : ${csvTable[i]}");
      items.add({
        'vehicle_number': csvTable[i][0].toString(),
        'report_time': csvTable[i][1].toString(),
        'report_location': csvTable[i][2].toString(),
        'image_path': csvTable[i][3].toString(),
        'report_status': csvTable[i][4].toString(),
        'latitude': double.tryParse(csvTable[i][5].toString()) ?? 0.0,
        'longitude': double.tryParse(csvTable[i][6].toString()) ?? 0.0,
      });
    }
    return items;
  } catch (e){
    print("Error loading CSV $e");
    return[];
  }
}