class LocationData {
  double lat;
  double lng;
  String timestamp;
  String date;
  bool isSended;

  LocationData({
    required this.lat,
    required this.lng,
    required this.timestamp,
    required this.date,
    this.isSended = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': lat,
      'longitude': lng,
      'timestamp': timestamp,
      'date': date,
      'isSended': isSended ? 1 : 0,
    };
  }

  LocationData.fromMap(Map<String, dynamic> map)
      : lat = map['latitude'],
        lng = map['longitude'],
        timestamp = map['timestamp'],
        date = map['date'],
        isSended = map['isSended'] == 1;
}
