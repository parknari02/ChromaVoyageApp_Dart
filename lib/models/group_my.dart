class Group {
  int groupId;
  String groupName;
  DateTime createdDate;
  bool pin;
  List<String> groupMembers;

  Group({
    required this.groupId,
    required this.groupName,
    required this.createdDate,
    required this.pin,
    required this.groupMembers,
  });

  // 이 메서드를 추가합니다.
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      groupName: json['groupName'],
      createdDate: DateTime.parse(json['createdDate']),
      pin: json['pin'],
      groupMembers: List<String>.from(json['groupMembers']),
    );
  }
}
