class run {
  String? latLong;
  String? time;
  double? km;
  int? userId;

  run({this.latLong, this.time, this.km, this.userId});

  run.fromJson(Map<String, dynamic> json) {
    latLong = json['lat_long'];
    time = json['time'];
    km = json['km'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat_long'] = this.latLong;
    data['time'] = this.time;
    data['km'] = this.km;
    data['user_id'] = this.userId;
    return data;
  }
}