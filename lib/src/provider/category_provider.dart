import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jabes/src/api/environment.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// Importa el UsersProvider

class CategoriesProvider {
  String _url = Environment.API_JABES;
  String _api = '/api/categories';
  late BuildContext context;
  User? sessionUser;
  UsersProvider usersProvider = UsersProvider(); // Instancia de UsersProvider

  void init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Categorys>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser?.sessionToken ?? ''
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser!.id!);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Categorys category = Categorys.fromJsonList(data);
      return category.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi?> create(Categorys category) async {
    try {
      // Obtén el ID del usuario logeado desde UsersProvider
      String? userId = usersProvider.sessionUser?.id;

      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode({
        'userId': userId,
        'name': category.name,
        'description': category.description,
      });

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser?.sessionToken ?? ''
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
