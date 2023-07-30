import 'dart:convert';

Categorys categorysFromJson(String str) => Categorys.fromJson(json.decode(str));

String categorysToJson(Categorys data) => json.encode(data.toJson());

class Categorys {
  String? id;
  String? name;
  String? description;
  List<Categorys> toList = [];

  Categorys({
    this.id,
    this.name,
    this.description,
  });

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
        id: json["id"] is int ? json["id"].toString() : json['id'],
        name: json["name"],
        description: json["description"],
      );

  Categorys.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Categorys categorys = Categorys.fromJson(item);
      toList.add(categorys);
    });
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
