// To parse this JSON data, do
//
//     final pagos = pagosFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

List<Pagos> pagosFromJson(String str) =>
    List<Pagos>.from(json.decode(str).map((x) => Pagos.fromJson(x)));

String pagosToJson(List<Pagos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pagos {
  String idPaymentMethod;
  double amount;
  String nameCause;
  DateTime date;
  String description;
  String idUser;

  Pagos({
    required this.idPaymentMethod,
    required this.amount,
    required this.nameCause,
    required this.date,
    required this.description,
    required this.idUser,
  });

  factory Pagos.fromJson(Map<String, dynamic> json) => Pagos(
        idPaymentMethod: json["id_payment_method"],
        amount: json["amount"],
        nameCause: json["name_cause"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_payment_method": idPaymentMethod,
        "amount": amount,
        "name_cause": nameCause,
        "date": date.toIso8601String(),
        "description": description,
        "id_user": idUser,
      };
}
