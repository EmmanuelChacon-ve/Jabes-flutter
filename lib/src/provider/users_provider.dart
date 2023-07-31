import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabes/src/api/environment.dart';
import 'package:jabes/src/models/causes.dart';
import 'package:jabes/src/models/pago.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/rol.dart';
import 'package:jabes/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:path/path.dart';

import '../models/category.dart';
import '../models/userhasroles.dart';

class UsersProvider {
  String _url = Environment.API_JABES;
  String _api = '/api/users';

  late BuildContext context;
  User? sessionUser;

  void init(BuildContext context, {User? sessionUser}) {
    this.context = context;
    this.sessionUser = sessionUser;
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

  Future<List<User>> getAllUsers() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      final res = await http.get(url);
      final data = json.decode(res.body);
      List<User> userList = [];
      for (var item in data) {
        userList.add(User.fromJson(item));
      }
      return userList;
    } catch (e) {
      print('Error: $e');
      return [];
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
        image;
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

  //obteniendo metodos de pago
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

  Future<List<Rol>> getAllrol() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAllrol');
      final res = await http.get(url);
      final data = json.decode(res.body);
      List<Rol> rolList = [];
      for (var item in data) {
        rolList.add(Rol.fromJson(item));
      }
      return rolList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<UserHasRoles>> getAlluser_has_roles() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAlluser_has_roles');
      final res = await http.get(url);
      final data = json.decode(res.body);
      List<UserHasRoles> hasList = [];
      for (var item in data) {
        hasList.add(UserHasRoles.fromJson(item));
      }
      return hasList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Causes>> getAllCauses() async {
    try {
      Uri url = Uri.http(_url, '$_api/findAllp');
      final res = await http.get(url);
      final data = json.decode(res.body);
      List<Causes> causesList = [];
      for (var item in data) {
        causesList.add(Causes.fromJson(item));
      }
      return causesList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Categorys>> getAllCategoria() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAllCategoria');
      final res = await http.get(url);
      final data = json.decode(res.body);
      List<Categorys> categorysList = [];
      for (var item in data) {
        categorysList.add(Categorys.fromJson(item));
      }
      return categorysList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
    //realizando insersencion dentro de la tabla pay
  }

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
  }
}
