import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/PlaceMemoDialogs.dart';
import '../widgets/VerticalLinePainter.dart';
import '../widgets/MyProvider.dart';




// void main() {
//   runApp(
//     ChangeNotifierProvider<MyProvider>(
//       create: (context) => MyProvider(),
//       builder: (context, _) => MaterialApp(
//         home: PlaceMemo(selectedLocation: "", selectedDate: ""),
//       ),
//     ),
//   );
// }

class PlaceMemo extends StatefulWidget {
  final String selectedLocation;
  final String selectedDate;
  final int groupId;
  final int locationId;
  final int coloringLocationId;

   const PlaceMemo({
    Key? key,
    required this.selectedLocation,
    required this.selectedDate,
    required this.groupId,
    required this.locationId,
    required this.coloringLocationId,
  }) : super(key: key);

  @override
  _PlaceMemoState createState() => _PlaceMemoState();
}

class _PlaceMemoState extends State<PlaceMemo> {
  List<String> places = [];
  List<String> memos = [];
  String newPlace = '';
  String newMemo = '';

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

    // final myProvider = Provider.of<MyProvider>(context);

    // // 가져온 데이터 사용
    final int locationId = widget.locationId;
    final int coloringLocationId = widget.coloringLocationId;
    final int groupId = widget.groupId;

    DateTime startDate =
        DateFormat('yyyy-MM-dd').parse(widget.selectedDate.split(' - ')[0]);
    DateTime endDate =
        DateFormat('yyyy-MM-dd').parse(widget.selectedDate.split(' - ')[1]);

    List<String> dateList = getDatesBetween(startDate, endDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 250, 250, 250), // Set background color to white
          elevation: 0, // Set elevation to 0 for no shadow
          title: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFB28EFF),
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '박나리님',
                style: TextStyle
                ( color: Color(0xFF6540B4) ,
                  fontSize: 14), // Adjust font size as needed
              ),
            ],
          ),
          actions: [ 
            IconButton(
              icon: Icon(Icons.menu, color: Color(0xFF6540B4), size: 30),
              onPressed: () {
                // Add your logic for the menu icon press
              },
            ),
          ],
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
          padding: EdgeInsets.only(top: 15, left: 15),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 380,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFE9E1FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '${widget.selectedLocation}',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Droid Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
              Padding(
          padding: EdgeInsets.only(top: 12, left: 15),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 380,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFE9E1FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '${widget.selectedDate}',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Droid Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
            ],
          ),
          SizedBox(height: 10),
          Divider( // 추가된 부분: Divider 위젯으로 수평 실선 추가
              color: const Color.fromARGB(255, 202, 202, 202), // 실선 색상 설정
              thickness: 1.0, // 실선 두께 설정
            ),
            
          Expanded(
            child: Container(
              
              
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'MY PLAN',
                          style: TextStyle(
                            color: Color(0xFF6540B4),
                            fontSize: 25,
                            fontFamily: 'Droid Sans',
                            fontWeight: FontWeight.w700,
                          ),
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
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      print(locationId);
                                      print(coloringLocationId);
                                      print(groupId);
                                      _showPlaceDialog(date);
                                    },
                                    child: Icon(
                                      Icons.add_location,
                                      color: Color(0xFFC19CFF),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
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
                                  children: placesAndMemosByDate[date]!
                                      .map((item) {
                                    if (item.startsWith('Place:')) {
  // 장소 정보 추출
  String placeInfo = item.replaceFirst('Place:', '');
  // 장소와 시간 분리
  List<String> placeAndTime = placeInfo.split(' ');

  return 
  
  
  Container(
    width: 250,
    margin: EdgeInsets.only(left: 30, top: 10, bottom: 10),
    padding: EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: Color.fromARGB(255, 246, 243, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 6,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 장소 정보 표시
        Text(
          '${placeAndTime[0]}',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        // 시간 정보 표시
        SizedBox(height: 5),
        Text(
          '${placeAndTime.sublist(1).join(' ')}',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
} else {
  return Container(
    margin: EdgeInsets.only(left: 30, top: 10, bottom: 10),
    padding: EdgeInsets.all(10),
    width: 250,
    decoration: ShapeDecoration(
      color: Color.fromARGB(255, 237, 242, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 6,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'add',
          ),
        ],
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF6540B4),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<void> _showPlaceDialog(String date) async {
  await PlaceMemoDialogs.showPlaceDialog(
    context,
    date,
    widget.groupId,  // Pass groupId
    widget.locationId,  // Pass locationId
    widget.coloringLocationId,  // Pass coloringLocationId
    (newPlace) {
      setState(() {
        if (placesAndMemosByDate.containsKey(date)) {
          placesAndMemosByDate[date]!.add(newPlace);
        } else {
          placesAndMemosByDate[date] = [newPlace];
        }
      });
    },
  );
}


  Future<void> _showMemoDialog(String date) async {
    await PlaceMemoDialogs.showMemoDialog(context, date, widget.groupId,  // Pass groupId
    widget.locationId,  // Pass locationId
    widget.coloringLocationId, (newMemo) {
      setState(() {
        if (placesAndMemosByDate.containsKey(date)) {
          placesAndMemosByDate[date]!.add(newMemo);
        } else {
          placesAndMemosByDate[date] = [newMemo];
        }
      });
    });
  }
}
