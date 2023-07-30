import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabes/src/api/environment.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/rol.dart';
import 'package:jabes/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:jabes/src/models/userData.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:path/path.dart';

class UsersProvider {
  String _url = Environment.API_JABES;
  String _api = '/api/users';

  late BuildContext context;
  User? sessionUser;

  void init(BuildContext context, {User? sessionUser}) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

//creamos funcion para llamar a los usuarios
  Future<List<User>> getUsuarios() async {
    Uri url = Uri.http(_url, '/api/admin/getAllUsers');
    Map<String, String> headers = {'Content-type': 'application/json'};

    try {
      final res = await http.get(url, headers: headers);
      final List<dynamic> dataList = json.decode(res.body);

      // Mapear la lista de datos a una lista de objetos User
      List<User> users = dataList.map((data) => User.fromJson(data)).toList();

      return users;
    } catch (e) {
      print('Error: $e');
      throw e; // Puedes lanzar la excepción para manejarla en el FutureBuilder
    }
  }

//creamos funcion para llamar a los roles
  Future<List<Rol>> getRol() async {
    Uri url = Uri.http(_url, '/api/admin/getRol');
    Map<String, String> headers = {'Content-type': 'application/json'};

    try {
      final res = await http.get(url, headers: headers);
      final List<dynamic> dataList = json.decode(res.body);

      // Mapear la lista de datos a una lista de objetos User
      List<Rol> users = dataList.map((data) => Rol.fromJson(data)).toList();

      return users;
    } catch (e) {
      print('Error: $e');
      throw e; // Puedes lanzar la excepción para manejarla en el FutureBuilder
    }
  }

  Future<User?> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser?.sessionToken ?? ''
      };
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 401) {
        //NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesion expiró');
        SharedPref().logout(context, sessionUser!.id!);
      }

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
      request.headers['Authorization'] = sessionUser?.sessionToken ?? '';

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // ENVIARA LA PETICION

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Tu sesion expiró');
        SharedPref().logout(context, sessionUser!.id!);
      }

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

  Future<ResponseApi?> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({'id': idUser});
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

  Future<ResponseApi?> insertarNuevoRol(UserData user) async {
    try {
      Uri url = Uri.http(_url, '/api/admin/insertRol');
      Map<String, String> headers = {'Content-type': 'application/json'};
      String bodyParams = json.encode(user.toJson());

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Estamos experimentando el siguiente error: $e');
      return null;
    }
  }
}
