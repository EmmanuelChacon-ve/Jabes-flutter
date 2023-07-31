// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  String idPaymentType;
  List<SelectorIdPaymentType> selectorIdPaymentType;

  Payment({
    required this.idPaymentType,
    required this.selectorIdPaymentType,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        idPaymentType: json["id_payment_type"],
        selectorIdPaymentType: List<SelectorIdPaymentType>.from(
            json["selector_id_payment_type"]
                .map((x) => SelectorIdPaymentType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_payment_type": idPaymentType,
        "selector_id_payment_type":
            List<dynamic>.from(selectorIdPaymentType.map((x) => x.toJson())),
      };
}

class SelectorIdPaymentType {
  String nombre;
  String imagen;

  SelectorIdPaymentType({
    required this.nombre,
    required this.imagen,
  });

  factory SelectorIdPaymentType.fromJson(Map<String, dynamic> json) =>
      SelectorIdPaymentType(
        nombre: json["nombre"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "imagen": imagen,
      };
}
