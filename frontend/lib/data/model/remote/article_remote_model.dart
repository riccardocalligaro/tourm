class ArticleRemoteModel {
  int id;
  String title;
  String subtitle;
  String imageUrl;
  String body;
  bool highlighted;
  int employeeId;
  String createdAt;
  String updatedAt;
  String name;
  String surname;
  String email;

  ArticleRemoteModel(
      {this.id,
      this.title,
      this.subtitle,
      this.imageUrl,
      this.body,
      this.highlighted,
      this.employeeId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.surname,
      this.email});

  ArticleRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    imageUrl = json['image_url'];
    body = json['body'];
    highlighted = json['highlighted'] == 1;
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image_url'] = imageUrl;
    data['body'] = body;
    data['highlighted'] = highlighted;
    data['employee_id'] = employeeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    return data;
  }
}
