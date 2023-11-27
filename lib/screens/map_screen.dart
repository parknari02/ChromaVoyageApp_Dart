import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        title: Text('Map Example'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.5665, 126.9780), // 서울의 좌표
          zoom: 7.0,
        ),
        polygons: Set<Polygon>.of(polygons),
      ),
    );
  }
}
