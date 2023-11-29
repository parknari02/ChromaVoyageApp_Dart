import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceMemoDialogs {
  
  static Future<void> showPlaceDialog(
      BuildContext context, String date, Function(String) onPlaceAdded) async {
    String newPlace = '';
    TimeOfDay selectedStartTime = TimeOfDay.now();
    TimeOfDay selectedEndTime = TimeOfDay.now();
    List<String> placeResults = [];
    TextEditingController _placeController = TextEditingController();

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
                        title: Text(placeResults[index]),
                        onTap: () {
                          setState(() {
                            newPlace = placeResults[index];
                            _placeController.text = newPlace;
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
                    await displayPlaceSearchResults(newPlace);
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

  static Future<List<String>> displayPlaceSearchResults(String query) async {
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
        List<String> placeResults = (data['documents'] as List)
          .map((place) => place['place_name'].toString())
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
    BuildContext context, List<String> placeResults, Function(String) onPlaceSelected) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200, // 적절한 높이를 지정하세요.
        child: ListView.builder(
          itemCount: placeResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(placeResults[index]),
              onTap: () {
                Navigator.of(context).pop();
                onPlaceSelected(placeResults[index]);
              },
            );
          },
        ),
      );
    },
  );
}


  static Future<void> showMemoDialog(
    BuildContext context, String date, Function(String) onMemoAdded) async {
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