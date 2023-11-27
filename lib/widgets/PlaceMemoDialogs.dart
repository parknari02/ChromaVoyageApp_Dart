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
    

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('장소 및 시간 추가'),
              content: Column(
                children: [
                  TextField(
                    onChanged: (value) async {
                      newPlace = value;
                      // 여기서 장소를 검색하고 결과를 표시하는 함수를 호출하세요.
                      // 검색 결과를 리스트로 받아와서 UI에 표시할 수 있습니다.
                      await displayPlaceSearchResults(value);
                    },
                    decoration: InputDecoration(
                      hintText: '장소를 입력하세요',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('시작 시간:'),
                            ElevatedButton(
                              onPressed: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: selectedStartTime,
                                );
                                if (pickedTime != null && pickedTime != selectedStartTime) {
                                  setState(() {
                                    selectedStartTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(selectedStartTime.format(context)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('종료 시간:'),
                            ElevatedButton(
                              onPressed: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: selectedEndTime,
                                );
                                if (pickedTime != null && pickedTime != selectedEndTime) {
                                  setState(() {
                                    selectedEndTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(selectedEndTime.format(context)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    String formattedPlace = 'Place:$newPlace ${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}';
      onPlaceAdded(formattedPlace);

                  await displayPlaceSearchResults(newPlace);
                  },
                  child: Text('추가'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> displayPlaceSearchResults(String query) async {
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
      // 여기에서 data를 활용하여 검색 결과를 처리하면 됩니다.
      // 예: 결과를 리스트로 저장하고 UI에 표시하는 등의 작업 수행
      print(data);
    } else {
      print('Failed to load places. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load places');
    }
  } catch (e) {
    print('Error during place search: $e');
  }
}

  static Future<void> showMemoDialog(BuildContext context, String date, Function(String) onMemoAdded) async {
    String newMemo = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('메모 추가'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newMemo = value;
                },
                decoration: InputDecoration(
                  hintText: '메모를 입력하세요',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onMemoAdded(newMemo);
                },
                child: Text('추가'),
              ),
            ],
          ),
        );
      },
    );
  }
}
