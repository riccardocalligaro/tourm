class AudioguideRemoteModel {
  int id;
  String title;
  int roomId;
  String path;
  int nVisitors;
  int openToPublic;
  String beaconId;
  String createdAt;
  String updatedAt;

  AudioguideRemoteModel({
    this.id,
    this.title,
    this.roomId,
    this.path,
    this.nVisitors,
    this.openToPublic,
    this.beaconId,
    this.createdAt,
    this.updatedAt,
  });

  AudioguideRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    roomId = json['room_id'];
    path = json['path'];
    nVisitors = json['n_visitors'];
    openToPublic = json['open_to_public'];
    beaconId = json['beacon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['room_id'] = roomId;
    data['path'] = path;
    data['n_visitors'] = nVisitors;
    data['open_to_public'] = openToPublic;
    data['beacon_id'] = beaconId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
