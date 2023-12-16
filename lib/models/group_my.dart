class MyGroup {
  int groupId;
  String groupName;
  DateTime createdDate;
  bool pin;
  List<String> groupMembers;

  MyGroup({
    required this.groupId,
    required this.groupName,
    required this.createdDate,
    required this.pin,
    required this.groupMembers,
  });

  // 이 메서드를 추가합니다.
  factory MyGroup.fromJson(Map<String, dynamic> json) {
    return MyGroup(
      groupId: json['groupId'],
      groupName: json['groupName'],
      createdDate: DateTime.parse(json['createdDate']),
      pin: json['pin'],
      groupMembers: List<String>.from(json['groupMembers']),
    );
  }
}
