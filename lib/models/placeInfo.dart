class PlaceInfo {
  final int placeListId;
  final int coloringLocationId;
  final int groupId;
  final String locationId;
  final DateTime createdDate;
  final String placeDate;
  final String placeName;
  final String startTime;
  final String endTime;
  final String address;
  final double latitude;
  final double longitude;

  PlaceInfo({
    required this.placeListId,
    required this.coloringLocationId,
    required this.groupId,
    required this.locationId,
    required this.createdDate,
    required this.placeDate,
    required this.placeName,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceInfo.fromJson(Map<String, dynamic> json) {
    return PlaceInfo(
      placeListId: json['placeListId'],
      coloringLocationId: json['coloringLocationId'],
      groupId: json['groupId'],
      locationId: json['locationId'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(json['createdDate']),
      placeDate: json['placeDate'],
      placeName: json['placeName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
