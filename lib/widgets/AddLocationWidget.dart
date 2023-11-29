import 'package:chromavoyage_client/main.dart';
import 'package:chromavoyage_client/screens/place_memo_screen.dart';
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
    "seoul", "서울", "광주", "부산", "대구", "인천", "대전", "울산", "경기", "강원", "충청", "전라", "경상"
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
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFB28EFF),  
                      ),
                    ),
        child: child!,
      );
    },
    
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 30),
              child: TextField(
                controller: location2Controller,
    
                onChanged: performSearch,
                decoration: InputDecoration(
                  hintText: '여행할 지역을 검색하세요',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 12,
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
                  padding: EdgeInsets.only(left: 20, right: 30),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: '여행날짜를 선택하세요',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 12,
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
                          fontSize: 12,
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
            
            
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: InkWell(
            onTap: () {
              // 이미지가 눌렸을 때 새로운 위젯으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaceMemo(
                  selectedLocation: location2Controller.text,
                  selectedDate: locationController.text,
                )), // 두 번째 위젯으로 이동
              );
            },
            child: Image.asset(
              'lib/assets/Group 10.png', // 이미지 경로를 설정하세요
              width:110, // 이미지의 폭을 조절하세요
              height:110, // 이미지의 높이를 조절하세요
            ),
          ),
          ),
          
            Text(
              '여행 계획을 추가하세요!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color:
                Colors.black.withOpacity(0.2),
              ),
            
          ),
          ],
        ),
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
          }
        },
      ),
    );
  }
}
