class ArticleRemoteModel {
  int id;
  String title;
  String body;
  int employeeId;
  String createdAt;
  String updatedAt;

  ArticleRemoteModel({
    this.id,
    this.title,
    this.body,
    this.employeeId,
    this.createdAt,
    this.updatedAt,
  });

  ArticleRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['employee_id'] = employeeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
