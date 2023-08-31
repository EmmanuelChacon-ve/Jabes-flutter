import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/utils/shared_pref.dart';

class ClientProductsDetailController {
  BuildContext? context;
  Function? refresh;
  Product? product;
  SharedPref sharedPref = SharedPref();

  void init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    print("productos $product");
    /*  print("producto: $addToDonation()"); */

    refresh();
  }

  Product? addToDonation() {
    if (product != null) {
      sharedPref.save('order', product!.toJson());
      Fluttertoast.showToast(msg: 'Producto agregado.');
      print('Producto agregado. ID: ${product!.id}');
    }
    return product;
  }
}
