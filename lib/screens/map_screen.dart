import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './main_screen.dart';
import './create_group_screen.dart';


void main() {
  runApp(MyMap());
}

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; // late 키워드 추가
  List<Polygon> polygons = [];

  @override
  void initState() {
    super.initState();
    loadPolygons();
  }

  Future<void> _onItemTapped(int index) async {
  if (index == 0) {  // 'map' 버튼을 눌렀을 때
    setState(() {
      _selectedIndex = index;
    });
  }

  else if (index == 1){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyMain(),
      ),
    );
  } 
  
  else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGroupScreen(),
      ),
    );
  }
}

  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  Future<void> loadPolygons() async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('lib/assets/location.json');
    Map<String, dynamic> geoJsonData = json.decode(jsonString);

    List<dynamic> features = geoJsonData['features'];

    features.forEach((feature) {
      List<dynamic> coordinates = feature['geometry']['coordinates'][0];
      String name = feature['properties']['SIG_KOR_NM'];

      List<LatLng> polygonLatLngs = coordinates.map<LatLng>((coordinate) {
        return LatLng(coordinate[1], coordinate[0]);
      }).toList();

      Polygon polygon = Polygon(
        polygonId: PolygonId(name),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: Color.fromARGB(255, 141, 6, 179),
        fillColor: Color.fromARGB(255, 224, 143, 243).withOpacity(0.1),
      );

      setState(() {
        polygons.add(polygon);
      });
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
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(35.9665, 127.7780), // 서울의 좌표
          zoom: 7.0,
        ),
        polygons: Set<Polygon>.of(polygons),
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
          onTap: _onItemTapped,
        ),
    );
  }
}
