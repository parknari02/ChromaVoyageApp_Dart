import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlaceMemo extends StatefulWidget {
  final String selectedLocation;
  final String selectedDate;

  PlaceMemo({required this.selectedLocation, required this.selectedDate});

  @override
  _PlaceMemoState createState() => _PlaceMemoState();
}

class _PlaceMemoState extends State<PlaceMemo> {
  List<String> places = [];
  List<String> memos = [];
  String newPlace = ''; // 새로운 장소 추가를 위한 변수
  String newMemo = ''; // 새로운 메모 추가를 위한 변수

  int _selectedIndex = 2;

  List<String> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<String> dates = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      dates.add(DateFormat('MM.dd').format(currentDate));
    }
    return dates;
  }

  Map<String, List<String>> placesAndMemosByDate = {};

  @override
  Widget build(BuildContext context) {
    DateTime startDate =
        DateFormat('yyyy-MM-dd').parse(widget.selectedDate.split(' - ')[0]);
    DateTime endDate =
        DateFormat('yyyy-MM-dd').parse(widget.selectedDate.split(' - ')[1]);

    List<String> dateList = getDatesBetween(startDate, endDate);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70, left: 25),
                child: Text(
                  '${widget.selectedLocation}',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Droid Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 25),
                child: Text(
                  '${widget.selectedDate}',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Droid Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight, // 화면 높이에서 바텀 네비게이션바 높이를 뺍니다.
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 197, 197, 197).withOpacity(0.7),
                    width: 1.0,
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                  
                  children: [
                    
                    Text(
                      'MY PLAN',
                      style: TextStyle(
                        color: Color(0xFF6540B4),
                        fontSize: 25,
                        fontFamily: 'Droid Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dateList.map((date) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Droid Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // 여기에서 장소 추가 창을 띄우고 입력된 장소를 처리하는 로직을 구현
                                    _showPlaceDialog(date);
                                  },
                                  child: Icon(
                                    Icons.add_location,
                                    color: Color(0xFFC19CFF),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // 여기에서 메모 추가 창을 띄우고 입력된 메모를 처리하는 로직을 구현
                                    _showMemoDialog(date);
                                  },
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    color: Color(0xFF8CB8FB),
                                  ),
                                ),
                              ],
                            ),
                            if (placesAndMemosByDate.containsKey(date))
                              Column(
                                children: placesAndMemosByDate[date]!.map((item) {
                                  if (item.startsWith('Place:')) {
                                    return Container(
                                      width: 250,
                                      margin: EdgeInsets.only(left: 30, top: 5, bottom: 15),
                                      padding: EdgeInsets.all(10),
                                       decoration: ShapeDecoration(
                                        color: Color(0xFFFBF9FF),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Text(
                                        item.replaceFirst('Place:', ''),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Droid Sans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return 
                                    Container(
                                      margin: EdgeInsets.only(left: 30, top: 5, bottom: 15),
                                      padding: EdgeInsets.all(10),
                                      width: 250,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF8FAFF),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Droid Sans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }
                                }).toList(),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_cloudy),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'add',
          ),
        ],
        selectedItemColor: Colors.white,
        backgroundColor: Colors.deepPurple[200],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.pop(context);
            Navigator.pop(context); // 두 번째 아이템을 선택하면 현재 페이지 닫기
          }
        },
      ),
    );
  }

  Future<void> _showPlaceDialog(String date) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('장소 추가'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    newPlace = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: '장소를 입력하세요',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (placesAndMemosByDate.containsKey(date)) {
                      placesAndMemosByDate[date]!.add('Place:$newPlace');
                    } else {
                      placesAndMemosByDate[date] = ['Place:$newPlace'];
                    }
                    newPlace = ''; // 새로운 장소 추가 후 초기화
                  });
                },
                child: Text('추가'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMemoDialog(String date) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('메모 추가'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    newMemo = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: '메모를 입력하세요',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (placesAndMemosByDate.containsKey(date)) {
                      placesAndMemosByDate[date]!.add(newMemo);
                    } else {
                      placesAndMemosByDate[date] = [newMemo];
                    }
                    newMemo = ''; // 새로운 메모 추가 후 초기화
                  });
                },
                child: Text('추가'),
              ),
            ],
          ),
        );
      },
    );
  }
}
