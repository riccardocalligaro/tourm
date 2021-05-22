class RoomArticleRemoteModel {
  String name;
  String surname;
  int id;
  String title;
  String body;

  RoomArticleRemoteModel({
    this.name,
    this.surname,
    this.id,
    this.title,
    this.body,
  });

  RoomArticleRemoteModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
