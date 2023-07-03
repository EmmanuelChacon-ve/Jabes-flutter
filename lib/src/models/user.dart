import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? password;

  User({
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
      };
}
