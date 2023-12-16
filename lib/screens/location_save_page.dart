import 'package:chromavoyage_client/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './create_group_screen.dart';
import 'package:http/http.dart' as http;

class LocationSave extends StatefulWidget {
  final String locationName;
  final String groupName;
  final DateTime startDate;
  final DateTime endDate;
  final int coloringLocationId;
  final int locationId;
  final int groupId;

  

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  LocationSave({
    required this.locationName,
    required this.groupName,
    required this.startDate,
    required this.endDate,
    required this.coloringLocationId,
    required this.groupId,
    required this.locationId,
  });

  @override
  _LocationSaveState createState() => _LocationSaveState();
}

 

  Future<void> _onItemTapped(BuildContext context, int index) async {
    if (index == 0) {
      // Handle index 0
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyMain(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroupScreen(),
        ),
      );
    }
  }

  class _LocationSaveState extends State<LocationSave> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<File> selectedImages = [];

   Future<void> _sendGetRequest() async {
    try {
      final String apiUrl = 'http://10.0.2.2:8080/places/list';
      final Map<String, dynamic> queryParams = {
        'group_id': widget.groupId.toString(),
        'coloring_location_id': widget.coloringLocationId.toString(),
      };

      final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

      final http.Response response = await http.get(uri);
      print('HTTP Response: ${response.body}');
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }

   @override
  void initState() {
    super.initState();
    // initState에서 HTTP 요청 보내고 응답을 출력
    _sendGetRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        elevation: 0,
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
              style: TextStyle(
                color: Color(0xFF6540B4),
                fontSize: 14,
              ),
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
        children: [
           Padding(
          padding: EdgeInsets.only(top: 15, left: 2),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 380,
            height: 40,
            decoration: ShapeDecoration(
            color: Color(0xFFF5F0FF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFB28EFF)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
            child: Text(
              '${widget.groupName}',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Droid Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
          Padding(
          padding: EdgeInsets.only(top: 12, left: 2),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 380,
            height: 40,
            decoration: ShapeDecoration(
            color: Color(0xFFF5F0FF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFB28EFF)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
            child: Text(
              '${DateFormat('yyyy-MM-dd').format(widget.startDate)}-${DateFormat('yyyy-MM-dd').format(widget.endDate)}',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Droid Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
            
          ),
          
        ),
        SizedBox(height: 20),
        
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 150, // Adjust the value as needed
              width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '나의 ${widget.locationName} 여행 기록',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Droid Sans',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6540B4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // 보라색 동그라미 추가
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(0xFFB28EFF),
                          ),
                          SizedBox(width: 8), // 동그라미와 글자 사이 간격 조절
                          Text(
                            '12.20',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
          '사천해변',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        // 시간 정보 표시
        SizedBox(height: 5),
        Text(
          "3:00 PM - 5:00 PM",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  ),
  Container(
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
      "해변 산책하기",
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Droid Sans',
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
                 Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // 보라색 동그라미 추가
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(0xFFB28EFF),
                          ),
                          SizedBox(width: 8), // 동그라미와 글자 사이 간격 조절
                          Text(
                            '12.21',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
          '강릉카페거리',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        // 시간 정보 표시
        SizedBox(height: 5),
        Text(
          '1:00 PM - 2:00 PM',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Droid Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // 보라색 동그라미 추가
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(0xFFB28EFF),
                          ),
                          SizedBox(width: 8), // 동그라미와 글자 사이 간격 조절
                          Text(
                            '12.22',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Additional content goes here
                  ],
                ),
              ),
            ),
          ),
          ImageUploadWidget(),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF6540B4),
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 8),
            Text(
                '이미지 업로드',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // 굵게 설정
                ),
              ),
            TextButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    selectedImages.add(File(image.path));
                  });
                }
              },
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF6540B4),
                ),
              ),
            ),
          ],
        ),
        if (selectedImages.isNotEmpty)
         Wrap(
            alignment: WrapAlignment.start,
            spacing: 16.0, // 이미지 간의 수평 간격
            runSpacing: 16.0, // 행 간의 수직 간격
            children: selectedImages.map((image) {
              return Container(
                width: 70,
                height: 70,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

