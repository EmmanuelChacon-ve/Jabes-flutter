import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? idUser; // Nuevo campo para almacenar el id del usuario
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;

  int? idCategory;
  int? quantity;
  List<Product> toList = [];

  Product({
    this.id,
    this.idUser,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.idCategory,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is int ? json["id"].toString() : json['id'],
        idUser: json["idUser"], // Asignar el valor del campo idUser desde JSON
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        idCategory: json["id_category"] is String
            ? int.parse(json["id_category"])
            : json["id_category"],
        quantity: json["quantity"],
      );

  Product.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Product product = Product.fromJson(item);
      toList.add(product);
    });
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser, // Incluir el campo idUser en la conversión a JSON
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "id_category": idCategory,
        "quantity": quantity,
      };

  /*  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble(); */
}
