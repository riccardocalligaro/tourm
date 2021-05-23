class RoomRemoteModel {
  int id;
  String imageUrl;
  String title;
  int nVisitors;
  bool openToPublic;
  String beaconId;
  String createdAt;
  String updatedAt;
  bool highlighted;

  RoomRemoteModel({
    this.id,
    this.imageUrl,
    this.title,
    this.nVisitors,
    this.openToPublic,
    this.beaconId,
    this.createdAt,
    this.updatedAt,
    this.highlighted,
  });

  RoomRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
    nVisitors = json['n_visitors'];
    openToPublic = json['open_to_public'];
    beaconId = json['beacon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    highlighted = json['highlighted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['n_visitors'] = nVisitors;
    data['open_to_public'] = openToPublic;
    data['beacon_id'] = beaconId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
