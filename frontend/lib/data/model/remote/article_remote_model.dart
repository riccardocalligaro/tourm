class ArticleRemoteModel {
  int id;
  String title;
  String subtitle;
  String imageUrl;
  String body;
  int employeeId;
  String createdAt;
  String updatedAt;
  bool highlighted;

  ArticleRemoteModel({
    this.id,
    this.title,
    this.body,
    this.employeeId,
    this.createdAt,
    this.updatedAt,
    this.highlighted,
    this.subtitle,
    this.imageUrl,
  });

  ArticleRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    highlighted = json['highlighted'];
    subtitle = json['subtitle'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['employee_id'] = employeeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['highlighted'] = highlighted;
    data['subtitle'] = subtitle;
    data['image_url'] = imageUrl;

    return data;
  }
}
