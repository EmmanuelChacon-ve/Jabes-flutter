import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jabes/src/api/environment.dart';
import 'package:jabes/src/models/pago.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider {
  String _url = Environment.API_JABES;
  String _api = '/api/users';
  late BuildContext context;
  void init(BuildContext context) {
    this.context = context;
  }

  Future<User?> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api//findById/$id');
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream?> createWithImage(User user, File? image) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream?> update(User user, File? image) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);

      if (image != null) {
        image;
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  dynamic metodosDePago() async {
    Uri url = Uri.http(_url, '$_api/payment');
    Map<String, String> headers = {'Content-type': 'application/json'};
    //agregar mas validaciones
    try {
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //realizando insersencion dentro de la tabla pay

  Future<Stream?> insertPago(Pagos pago, File? image) async {
    try {
      //creando url
      Uri url = Uri.http(_url, '$_api/insertPayment');
      //creando un multipartURL
      final request = http.MultipartRequest('POST', url);
      //crenado instancia de la imagen
      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }
      //Creando archivos a enviar
      request.fields['pago'] = json.encode(pago.toJson());
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('El error ah sido $e');
      return null;
    }

    //
  }
}
