import 'dart:convert';

Causes causesFromJson(String str) => Causes.fromJson(json.decode(str));

String causesToJson(Causes data) => json.encode(data.toJson());

class Causes {
  String? id;
  String? name;
  String? description;
  String? id_category;

  Causes({
    this.id,
    this.name,
    this.description,
    this.id_category,
  });

  factory Causes.fromJson(Map<String, dynamic> json) => Causes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        id_category: json["id_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "id_category": id_category,
      };
}
