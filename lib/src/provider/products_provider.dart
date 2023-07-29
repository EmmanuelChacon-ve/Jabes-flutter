import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jabes/src/api/environment.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductsProvider {
  String _url = Environment.API_JABES;
  String _api = '/api/products';
  late BuildContext context;
  User? sessionUser;

  void init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  /* Future<List<Product>> getAllProducts() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAllProducts');
      final res = await http.get(url);
      final allProducts = json.decode(res.body);
      List<Product> ProductList = [];
      for (var item in allProducts) {
        ProductList.add(Product.fromJson(item));
      }
      return ProductList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  } */
/*   Future<List<Product>> getAllProducts() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAllProducts');
      final res = await http.get(url);
      final allProductsData = json.decode(res.body);
      List<Product> productList = [];
      for (var item in allProductsData) {
        productList.add(Product.fromJson(item));
      }
      print('ProductList: $productList');
      return productList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  } */

  Future<List<Product>> getByCategory(String idCategory) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken ?? ''
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser!.id!);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      return product.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> getByCategoryAndProductName(
      String idCategory, String productName) async {
    try {
      Uri url = Uri.http(
          _url, '$_api/findByCategoryAndProductName/$idCategory/$productName');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken ?? ''
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser!.id!);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      return product.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream?> create(
      Product product, List<File> images, String id_user) async {
    // Agregar el parámetro id_user a la función create
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken ?? '';

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)));
      }

      // Agregar el campo id_user al JSON antes de enviar la solicitud
      Map<String, dynamic> productJson = product.toJson();
      productJson["id_user"] = id_user;

      request.fields['product'] = json.encode(productJson);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
