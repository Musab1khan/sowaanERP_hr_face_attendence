class TodayCheckinModel {
  String? log_type;
  String? time;

  TodayCheckinModel({
    this.log_type,
    this.time,
  });

  // fromJson
  TodayCheckinModel.fromJson(Map<String, dynamic> json) {
    log_type = json['log_type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['log_type'] = this.log_type;
    data['time'] = this.time;
    return data;
  }
}
