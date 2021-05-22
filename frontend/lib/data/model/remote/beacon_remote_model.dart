class BeaconRemoteModel {
  String uuid;
  String name;

  BeaconRemoteModel({this.uuid, this.name});

  BeaconRemoteModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    return data;
  }
}
