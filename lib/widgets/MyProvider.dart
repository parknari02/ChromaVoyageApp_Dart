import 'dart:ffi';
import 'package:flutter/foundation.dart';

class MyProvider with ChangeNotifier {
  int _locationId = 0;
  int _coloringLocationId = 0;
  int _groupId = 0;

  // Getter 메서드
  int get locationId => _locationId;
  int get coloringLocationId => _coloringLocationId;
  int get groupId => _groupId;

  // Setter 메서드
  void setIds(int locationId, int coloringLocationId, int groupId) {
    _locationId = locationId;
    _coloringLocationId = coloringLocationId;
    _groupId = groupId;

    // 데이터가 업데이트되었음을 Provider에 알림
    notifyListeners();
  }
}
