import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: AddLocation(),
  ));
}

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final locationController = TextEditingController();
  final location2Controller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List<String> koreanLocations = [
    "서울", "광주", "부산", "대구", "인천", "대전", "울산", "경기", "강원", "충청", "전라", "경상"
  ];

  String selectedLocation = "";
  List<String> filteredLocations = [];

  int _selectedIndex = 2;

  Future<void> _selectDate(BuildContext context) async {
  DateTimeRange? pickedDateRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime(2050),
    initialDateRange: DateTimeRange(
      start: selectedDate,
      end: selectedDate,
    ),
  );

  if (pickedDateRange != null) {
    setState(() {
      selectedDate = pickedDateRange.start;
      locationController.text =
          '${DateFormat('yyyy-MM-dd').format(pickedDateRange.start)} - ${DateFormat('yyyy-MM-dd').format(pickedDateRange.end)}';
    });
  }
}

  void performSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredLocations = koreanLocations
            .where((location) => location.contains(query))
            .toList();
      } else {
        filteredLocations.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 50),
              child: TextField(
                controller: location2Controller,
    
                onChanged: performSearch,
                decoration: InputDecoration(
                  hintText: '여행할 지역을 검색하세요',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 11,
                    fontFamily: 'Droid Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 50),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: '여행날짜를 선택하세요',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 11,
                        fontFamily: 'Droid Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
                          ),
            if (filteredLocations.isNotEmpty)
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredLocations[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Droid Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                         location2Controller.text = filteredLocations[index];
                         filteredLocations = [];
                        });

                        // Handle location selection if needed
                      },
                    );
                  },
                ),
              ),
          ],
        ),
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
          }
        },
      ),
    );
  }
}
