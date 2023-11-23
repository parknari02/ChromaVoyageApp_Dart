import 'package:flutter/material.dart';

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
                    onChanged: (value) {
                      newPlace = value;
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    String formattedPlace = 'Place:$newPlace ${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}';
      onPlaceAdded(formattedPlace);
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
