import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './main_screen.dart';
import './create_group_screen.dart';
import './location_save_page.dart';
import 'package:http/http.dart' as http; 

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
  List<Marker> markers = [];
  String selectedLocation = "";

  @override
  void initState() {
    super.initState();
    loadPolygons();
    fetchData();
    fetchData2();
  }

  Future<void> fetchData2() async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/places/totalList'),
    );

    if (response.statusCode == 200) {
      List<dynamic> placeList = json.decode(utf8.decode(response.bodyBytes));

      List<Marker> updatedMarkers = [];

      placeList.forEach((place) {
        double latitude = place['latitude'];
        double longitude = place['longitude'];
        String placeName = place['placeName'];

       BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);

      Marker marker = Marker(
        markerId: MarkerId(placeName),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: placeName),
        icon: markerIcon,
      );

        updatedMarkers.add(marker);
      });

      setState(() {
        markers = updatedMarkers;
      });
    } else {
      print('Data load failed. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/locations'),
        body: json.encode({'userId': 4}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<String> locations = json.decode(utf8.decode(response.bodyBytes)).cast<String>();

        // 업데이트된 폴리곤을 저장할 새로운 리스트 생성
        List<Polygon> updatedPolygons = [];

        // 받아온 지역을 반복하면서 폴리곤을 업데이트
        polygons.forEach((polygon) {
          String locationName = polygon.polygonId.value;

          // 현재 폴리곤이 받아온 지역에 해당하는지 확인
          if (locations.contains(locationName)) {
            // 업데이트된 속성을 가진 새로운 폴리곤 생성
            Polygon updatedPolygon = Polygon(
              polygonId: PolygonId(locationName),
              points: polygon.points,
              strokeWidth: polygon.strokeWidth,
              strokeColor: polygon.strokeColor,
              fillColor: Color.fromARGB(140, 142, 39, 176),
              onTap: () {
                setState(() {
                  selectedLocation = locationName;
                });
                showBottomSheet(locationName);
              },
            );

            // 업데이트된 폴리곤을 리스트에 추가
            updatedPolygons.add(updatedPolygon);
          } else {
            // 현재 폴리곤이 받아온 지역에 해당하지 않으면 그대로 추가
            updatedPolygons.add(polygon);
          }
        });

        // 새로운 폴리곤 리스트로 상태 업데이트
        setState(() {
          polygons = updatedPolygons;
        });
      } else {
        print('데이터 로드 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('에러: $e');
    }
  }

  Future<void> _onItemTapped(int index) async {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
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

void showBottomSheet(String locationName) async {
  print(locationName);
  if (locationName.isNotEmpty) {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/groups/location'),
        body: json.encode({'userId': 4, 'locationName': locationName}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("요청감");
        List<dynamic> groupData = json.decode(utf8.decode(response.bodyBytes));
        print(groupData);

        // BottomSheet 표시
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '나의 $locationName 여행',
                    style: TextStyle(
                                      color: Color(0xFF462193),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold, // Adjust font weight
                                      fontFamily: 'Do Hyeon',
                                      
                                    ),
                  ),
                  SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        groupData.length,
                        (index) {
                          int startDateInMillis = groupData[index]['startDate'];
                          int endDateInMillis = groupData[index]['endDate'];
                          String groupName = groupData[index]['groupName'];
                          int coloringLocationId = groupData[index]['coloringLocationId'];
                          int locationId = groupData[index]['locationId'];
                          int groupId = groupData[index]['groupId'];

                          // Convert to local time
                          DateTime startDateUTC = DateTime.fromMillisecondsSinceEpoch(startDateInMillis, isUtc: true);
                          DateTime endDateUTC = DateTime.fromMillisecondsSinceEpoch(endDateInMillis, isUtc: true);
                          DateTime startDate = startDateUTC.toLocal();
                          DateTime endDate = endDateUTC.toLocal();

                          return 
                                Container(
                                  width: 100.0,
                                  margin: EdgeInsets.only(right: 16.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 240, 255),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(13),
                                  child: GestureDetector(
                                    onTap: () {
                                    print("Container tapped"); // 디버그 메시지 추가
                                    // Navigate to LocationSave when the rectangle is tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LocationSave(
                                          locationName: locationName,
                                          groupName: groupName,
                                          startDate: startDate,
                                          endDate: endDate,
                                          coloringLocationId: coloringLocationId,
                                          locationId: locationId,
                                          groupId: groupId,
                                        ),
                                      ),
                                    );
                                  },

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$groupName',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 12,),
                                        Text(
                                          '${DateFormat('yyyy-MM-dd').format(startDate)}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          '~ ${DateFormat('yyyy-MM-dd').format(endDate)}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        print('데이터 로드 실패. 상태 코드: ${response.statusCode}');
        // 오류 처리
      }
    } catch (e) {
      print('에러: $e');
      // 오류 처리
    }
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
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(35.9665, 127.7780),
          zoom: 7.0,
        ),
        polygons: Set<Polygon>.of(polygons),
         markers: Set<Marker>.of(markers),
        onTap: (LatLng latLng) {
          String selectedLocation = identifyLocation(latLng);
          if (selectedLocation.isNotEmpty) {
            showBottomSheet(selectedLocation);
          }
        },
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

  String identifyLocation(LatLng latLng) {
  for (Polygon polygon in polygons) {
    if (isLocationInsidePolygon(latLng, polygon.points)) {
      return polygon.polygonId.value;
    }
  }
  return "";
}

bool isLocationInsidePolygon(LatLng location, List<LatLng> polygonPoints) {
  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length - 1; j++) {
      if ((polygon[j].latitude >= point.latitude && polygon[j + 1].latitude < point.latitude) ||
          (polygon[j + 1].latitude >= point.latitude && polygon[j].latitude < point.latitude)) {
        if (polygon[j].longitude + (point.latitude - polygon[j].latitude) /
                (polygon[j + 1].latitude - polygon[j].latitude) * (polygon[j + 1].longitude - polygon[j].longitude) <
            point.longitude) {
          intersectCount++;
        }
      }
    }
    return intersectCount % 2 == 1;
  }

  return isPointInPolygon(location, polygonPoints);
}

}
