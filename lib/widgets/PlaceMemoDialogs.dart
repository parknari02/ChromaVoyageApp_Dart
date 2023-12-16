import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceMemoDialogs {
  static Future<void> savePlaceToServer({
  required String coloringLocationId,
  required String groupId,
  required String locationId,
  required String placeName,
  required String address,
  required String latitude,
  required String longitude,
  required String placeDate,
  required String startTime,
  required String endTime,
}) async {
  
  final apiUrl = 'http://10.0.2.2:8080/places/save'; // 실제 서버의 API 엔드포인트로 변경

  final requestBody = {
    'coloringLocationId': coloringLocationId,
    'groupId': groupId,
    'locationId': locationId,
    'placeName': placeName,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'placeDate': placeDate,
    'startTime': startTime,
    'endTime': endTime,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    print('HTTP Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // 성공적으로 처리된 경우 추가적인 로직을 수행할 수 있습니다.
    } else {
      print('Failed to save place. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // 실패 처리 로직을 수행하세요.
    }
  } catch (e) {
    print('Error during place save: $e');
    // 오류 처리 로직을 수행하세요.
  }
}
static Future<void> saveMemoToServer({
  required String date,
  required String coloringLocationId,
  required String groupId,
  required String locationId,
  required String memo,
}) async {
  final apiUrl = 'http://10.0.2.2:8080/memos/save'; // 실제 서버의 API 엔드포인트로 변경

  final requestBody = {
    
    'memoContent': memo,
    'coloringLocationId' : coloringLocationId,
    'groupId': groupId,
    'locationId': locationId,
    'memoDate': date,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    print('HTTP Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // 성공적으로 처리된 경우 추가적인 로직을 수행할 수 있습니다.
    } else {
      print('Failed to save memo. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // 실패 처리 로직을 수행하세요.
    }
  } catch (e) {
    print('Error during memo save: $e');
    // 오류 처리 로직을 수행하세요.
  }
}
  
  static Future<void> showPlaceDialog(
    BuildContext context,
    String date,
    int groupId,
    int locationId,
    int coloringLocationId,
    Function(String) onPlaceAdded,
) async {
  String newPlace = '';
  PlaceInfo? selectedPlace;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  List<PlaceInfo> placeResults = [];
    
    
    TextEditingController _placeController = TextEditingController();
    print('groupId: $groupId');
  print('locationId: $locationId');
  print('coloringLocationId: $coloringLocationId');


    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return  SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: 
              
              Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _placeController,
                    onChanged: (value) async {
                      setState(() {
                        newPlace = value;
                      });
                      placeResults = await displayPlaceSearchResults(value);
                    },
                    decoration: InputDecoration(
                      hintText: '추가할 장소를 입력하세요',
                    ),
                  ),
                ),
                Container(
                    height: 180,
                    child: ListView.builder(
                      itemCount: placeResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(placeResults[index].name), // 장소 이름 사용
                          onTap: () {
                            setState(() {
                              newPlace = placeResults[index].name; // 또는 다른 필요한 속성 사용
                              _placeController.text = newPlace;
                              selectedPlace = placeResults[index];
                            });
                          },
                        );
                      },
                    ),
                  ),
                
                 Align(
                  alignment: Alignment.centerLeft, // 오른쪽 정렬
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '시간 설정하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                  
                  Divider(
                    color: Color.fromARGB(255, 222, 222, 222),
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        
                        children: [
                          Text('시작 시간:'),
                          ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 1, minute: 0),
                              );
                              if (pickedTime != null &&
                                  pickedTime != selectedStartTime) {
                                setState(() {
                                  selectedStartTime = pickedTime;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6540B4), // 보라색으로 변경
                            
                            ),

                            child: Text(selectedStartTime.format(context)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        
                        children: [
                          Text('종료 시간:'),
                          ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 0, minute: 0),
                              );
                              if (pickedTime != null &&
                                  pickedTime != selectedEndTime) {
                                setState(() {
                                  selectedEndTime = pickedTime;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6540B4), // 보라색으로 변경
                            
                            ),
                            child: Text(selectedEndTime.format(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {

                    
                    Navigator.of(context).pop();
                    String formattedPlace =
                        'Place:$newPlace ${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}';
                    onPlaceAdded(formattedPlace);

                    await savePlaceToServer(
                      coloringLocationId: coloringLocationId.toString(),
                      groupId: groupId.toString(),
                      locationId: locationId.toString(),
                      placeName: selectedPlace?.name ?? '',
                      address: selectedPlace?.address ?? '',
                      latitude: selectedPlace?.latitude ?? '',
                      longitude: selectedPlace?.longitude ?? '',
                      placeDate: date,
                      startTime: selectedStartTime.format(context),
                      endTime: selectedEndTime.format(context),
                    );

                    selectedPlace = null;
                    placeResults = [];
                    
                  },
                  style: ElevatedButton.styleFrom(
                  primary: Color(0xFF6540B4), // 보라색으로 변경
                  fixedSize: Size.fromWidth(310), // 원하는 가로 크기로 설정
                  ),
                  child: Text('장소 추가'),
                ),
              ],
            ),
           
            );
          },
        );
      },
    );
  }

 static Future<List<PlaceInfo>> displayPlaceSearchResults(String query) async {
  print('함수실행');
  await dotenv.load();
  final apiKey = dotenv.env['KAKAO_API_KEY'];
  final apiUrl = 'https://dapi.kakao.com/v2/local/search/keyword.json?query=$query';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'KakaoAK $apiKey'},
    );

    print('HTTP Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<PlaceInfo> placeResults = (data['documents'] as List)
        .map((place) => PlaceInfo(
          name: place['place_name'].toString(),
          address: place['address_name'].toString(),
          latitude: place['y'].toString(),
          longitude: place['x'].toString(),
        ))
        .toList();
      return placeResults;
    } else {
      print('Failed to load places. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load places');
    }
  } catch (e) {
    print('Error during place search: $e');
    return [];
  }
}


  static Future<void> showPlaceSelectionDialog(
    BuildContext context, List<PlaceInfo> placeResults, Function(String) onPlaceSelected) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200, // 적절한 높이를 지정하세요.
        child: ListView.builder(
          itemCount: placeResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(placeResults[index].name),
              onTap: () {
                Navigator.of(context).pop();
                onPlaceSelected(placeResults[index].name);
              },
            );
          },
        ),
      );
    },
  );
}


  static Future<void> showMemoDialog(
    BuildContext context, String date, int groupId,
    int locationId,
    int coloringLocationId, Function(String) onMemoAdded) async {
  String newMemo = '';
  TextEditingController _memoController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                 Align(
                  alignment: Alignment.centerLeft, // 오른쪽 정렬
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '메모 추가하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _memoController,
                    onChanged: (value) {
                      setState(() {
                        newMemo = value;
                      });
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                    hintText: '추가할 메모를 입력하세요',
                    border: OutlineInputBorder(), // 네모박스 스타일
                  ),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () async {
                          Navigator.of(context).pop();
                          onMemoAdded(newMemo);

                          await saveMemoToServer(
                            coloringLocationId: coloringLocationId.toString(),
                            groupId: groupId.toString(),
                             locationId: locationId.toString(),
                            date: date,
                            memo: newMemo,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6540B4), // 보라색으로 변경
                    fixedSize: Size.fromWidth(310), // 원하는 가로 크기로 설정
                  ),
                  child: Text('메모 추가'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}

class PlaceInfo {
  final String name;
  final String address;
  final String latitude;
  final String longitude;

  PlaceInfo({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}


