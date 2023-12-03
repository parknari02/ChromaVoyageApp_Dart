import 'package:chromavoyage_client/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './create_group_screen.dart';

class LocationSave extends StatelessWidget {
  final String locationName;
  final String groupName;
  final DateTime startDate;
  final DateTime endDate;

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  LocationSave({
    required this.locationName,
    required this.groupName,
    required this.startDate,
    required this.endDate,
  });

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
            height: 35,
            decoration: ShapeDecoration(
            color: Color(0xFFF5F0FF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFB28EFF)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
            child: Text(
              '${groupName}',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Droid Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
                 Padding(
          padding: EdgeInsets.only(top: 12, left: 2),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 380,
            height: 35,
            decoration: ShapeDecoration(
            color: Color(0xFFF5F0FF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFB28EFF)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
            child: Text(
              '${DateFormat('yyyy-MM-dd').format(startDate)}-${DateFormat('yyyy-MM-dd').format(endDate)}',
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
                        '나의 ${locationName} 여행 기록',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Droid Sans',
                          fontWeight: FontWeight.w700,
                        ),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('이미지 업로드'),
        ElevatedButton(
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

            if (image != null) {
              File selectedImage = File(image.path);
              // TODO: Handle the selected image
            }
          },
          child: Icon(
            Icons.add,
            color: Color(0xFFC19CFF),
        ),
        ),
        // TODO: Add code for displaying the selected image
      ],
    );
  }
}
