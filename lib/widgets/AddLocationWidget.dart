import 'dart:convert';
import 'dart:ffi';

import 'package:chromavoyage_client/main.dart';
import 'package:chromavoyage_client/screens/place_memo_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './MyProvider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          home: AddLocation(groupId: 0),
        ),
      ),
    ),
  );
}


class AddLocation extends StatefulWidget {
  final int groupId;

  const AddLocation({Key? key, required this.groupId}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final locationController = TextEditingController();
  final location2Controller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void sendPostRequest() async {
  final String apiUrl = 'http://10.0.2.2:8080'; // Replace with your actual base API URL
  final groupId = widget.groupId;
  final String groupId2 = widget.groupId.toString();
  

   List<String> dateParts = locationController.text.split(' - ');
  String startDateText = dateParts[0];
  String endDateText = dateParts[1];



  Map<String, dynamic> requestBody = {
    "userId": 4,
    "locationName": [location2Controller.text],
    "startDate": startDateText,
    "endDate": endDateText,
  };

     try {
    final response = await http.post(
      Uri.parse('$apiUrl/locations/add?group_id=$groupId2'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Successfully sent the data
      print('Post request successful');
      print(response.body);

      // Parse the response body
      List<dynamic> responseBody = json.decode(response.body);

      // Extract locationId, coloringLocationId, groupId
      for (var item in responseBody) {
        print(item);
        final Map<String, dynamic> data = item as Map<String, dynamic>;
        final int locationId = data['locationId'] ;
        final int coloringLocationId = data['coloringLocationId'] ;

        // Use the extracted data as needed

        // Example: Print the values
        print('LocationId: $locationId, ColoringLocationId: $coloringLocationId, GroupId: $groupId2');

        // ignore: use_build_context_synchronously
        // Provider.of<MyProvider>(context, listen: false).setIds(locationId, coloringLocationId, groupId);

         Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceMemo(
                      selectedLocation: location2Controller.text,
                      selectedDate: locationController.text,
                      groupId: groupId,
                      locationId: locationId,
                      coloringLocationId: coloringLocationId,
                    ),
                  ),
                );
      }
          // Navigate to the next screen with data as arguments
      
    } else {
      print("실패");
      // Error handling
      print('Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Exception handling
    print('Exception during post request: $e');
  }
}

  List<String> koreanLocations = [
      '춘천시',
  '원주시',
  '강릉시',
  '동해시',
  '태백시',
  '속초시',
  '삼척시',
  '홍천군',
  '횡성군',
  '영월군',
  '평창군',
  '정선군',
  '철원군',
  '화천군',
  '양구군',
  '인제군',
  '고성군',
  '양양군',
  '수원시 장안구',
  '수원시 권선구',
  '수원시 팔달구',
  '수원시 영통구',
  '성남시 수정구',
  '성남시 중원구',
  '성남시 분당구',
  '의정부시',
  '안양시 만안구',
  '안양시 동안구',
  '부천시',
  '광명시',
  '평택시',
  '동두천시',
  '안산시 상록구',
  '안산시 단원구',
  '고양시 덕양구',
  '고양시 일산동구',
  '고양시 일산서구',
  '과천시',
  '구리시',
  '남양주시',
  '오산시',
  '시흥시',
  '군포시',
  '의왕시',
  '하남시',
  '용인시 처인구',
  '용인시 기흥구',
  '용인시 수지구',
  '파주시',
  '이천시',
  '안성시',
  '김포시',
  '화성시',
  '광주시',
  '양주시',
  '포천시',
  '여주시',
  '연천군',
  '가평군',
  '양평군',
  '창원시 의창구',
  '창원시 성산구',
  '창원시 마산합포구',
  '창원시 마산회원구',
  '창원시 진해구',
  '진주시',
  '통영시',
  '사천시',
  '김해시',
  '밀양시',
  '거제시',
  '양산시',
  '의령군',
  '함안군',
  '창녕군',
  '고성군',
  '남해군',
  '하동군',
  '산청군',
  '함양군',
  '거창군',
  '합천군',
  '포항시 남구',
  '포항시 북구',
  '경주시',
  '김천시',
  '안동시',
  '구미시',
  '영주시',
  '영천시',
  '상주시',
  '문경시',
  '경산시',
  '군위군',
  '의성군',
  '청송군',
  '영양군',
  '영덕군',
  '청도군',
  '고령군',
  '성주군',
  '칠곡군',
  '예천군',
  '봉화군',
  '울진군',
  '울릉군',
  '광주 동구',
  '광주 서구',
  '광주 남구',
  '광주 북구',
  '광주 광산구',
  '대구 중구',
  '대구 동구',
  '대구 서구',
  '대구 남구',
  '대구 북구',
  '대구 수성구',
  '대구 달서구',
  '대구 달성군',
  '대전 동구',
  '대전 중구',
  '대전 서구',
  '대전 유성구',
  '대전 대덕구',
  '부산 중구',
  '부산 서구',
  '부산 동구',
  '부산 부산진구',
  '부산 동래구',
  '부산 남구',
  '부산 북구',
  '부산 해운대구',
  '부산 사하구',
  '부산 금정구',
  '부산 강서구',
  '부산 연제구',
  '부산 수영구',
  '부산 사상구',
  '부산 기장군',
  '서울 종로구',
  '서울 중구',
  '서울 용산구',
  '서울 성동구',
  '서울 광진구',
  '서울 동대문구',
  '서울 중랑구',
  '서울 성북구',
  '서울 강북구',
  '서울 도봉구',
  '서울 노원구',
  '서울 은평구',
  '서울 서대문구',
  '서울 마포구',
  '서울 양천구',
  '서울 강서구',
  '서울 구로구',
  '서울 금천구',
  '서울 영등포구',
  '서울 동작구',
  '서울 관악구',
  '서울 서초구',
  '서울 강남구',
  '서울 송파구',
  '서울 강동구',
  '세종특별자치시',
  '울산 중구',
  '울산 남구',
  '울산 동구',
  '울산 북구',
  '울산 울주군',
  '인천 중구',
  '인천 동구',
  '인천 미추홀구',
  '인천 연수구',
  '인천 남동구',
  '인천 부평구',
  '인천 계양구',
  '인천 서구',
  '인천 강화군',
  '인천 옹진군',
  '목포시',
  '여수시',
  '순천시',
  '나주시',
  '광양시',
  '담양군',
  '곡성군',
  '구례군',
  '고흥군',
  '보성군',
  '화순군',
  '장흥군',
  '강진군',
  '해남군',
  '영암군',
  '무안군',
  '함평군',
  '영광군',
  '장성군',
  '완도군',
  '진도군',
  '신안군',
  '전주시 완산구',
  '전주시 덕진구',
  '군산시',
  '익산시',
  '정읍시',
  '남원시',
  '김제시',
  '완주군',
  '진안군',
  '무주군',
  '장수군',
  '임실군',
  '순창군',
  '고창군',
  '부안군',
  '제주시',
  '서귀포시',
  '천안시 동남구',
  '천안시 서북구',
  '공주시',
  '보령시',
  '아산시',
  '서산시',
  '논산시',
  '계룡시',
  '당진시',
  '금산군',
  '부여군',
  '서천군',
  '청양군',
  '홍성군',
  '예산군',
  '태안군',
  '청주시 상당구',
  '청주시 서원구',
  '청주시 흥덕구',
  '청주시 청원구',
  '충주시',
  '제천시',
  '보은군',
  '옥천군',
  '영동군',
  '증평군',
  '진천군',
  '괴산군',
  '음성군',
  '단양군',
    
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
                height: 500,
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredLocations[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
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
                print(widget.groupId);
                sendPostRequest(); // Send the POST request when the image is tapped
               
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

