import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/provider/category_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/product.dart';
import '../../../../models/user.dart';
import '../../../../provider/products_provider.dart';
import '../../../../utils/shared_pref.dart';
import '../detail/client_produts_detail_page.dart';

class ClientProductsListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = new ProductsProvider();

  List<Categorys> categories = [];

  Timer? searchOnStoppedTyping;
  String productName = '';

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
    print('User data: $userData');
    productsProvider.init(context, user!);

    categoriesProvider.init(context, user!);
    getCategories();
  }

  Future<List<Product>> getProducts(
      String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await productsProvider.getByCategory(idCategory);
    } else {
      return await productsProvider.getByCategoryAndProductName(
          idCategory, productName);
    }
  }

  void getCategories() async {
    categories = await categoriesProvider.getAll();
    print('Categories: $categories');
    refresh!();
  }

  void gotoDetail(Product product) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CLientProductsDetailPage(
        product: product,
      ),
    );
  }

  void logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void gotoUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void onChangeText(String text) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
      refresh!();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName = text;
      refresh!();
      // getProducts(idCategory, text)
      print('TEXTO COMPLETO $text');
    });
  }
}
