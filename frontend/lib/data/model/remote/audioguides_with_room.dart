class AudioguideWithRoomRemoteModel {
  int id;
  String title;
  int roomId;
  String path;
  String imageUrl;
  int nVisitors;
  int openToPublic;
  int highlighted;
  String beaconId;
  String createdAt;
  String updatedAt;

  AudioguideWithRoomRemoteModel({
    this.id,
    this.title,
    this.roomId,
    this.path,
    this.imageUrl,
    this.nVisitors,
    this.openToPublic,
    this.highlighted,
    this.beaconId,
    this.createdAt,
    this.updatedAt,
  });

  AudioguideWithRoomRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    roomId = json['room_id'];
    path = json['path'];
    imageUrl = json['image_url'];
    nVisitors = json['n_visitors'];
    openToPublic = json['open_to_public'];
    highlighted = json['highlighted'];
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
    data['image_url'] = imageUrl;
    data['n_visitors'] = nVisitors;
    data['open_to_public'] = openToPublic;
    data['highlighted'] = highlighted;
    data['beacon_id'] = beaconId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
