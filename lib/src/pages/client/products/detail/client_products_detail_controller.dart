import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:jabes/src/models/product.dart';

class ClientProductsDetailController {
  BuildContext? context;
  Function? refresh;
  Product? product;
  void init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    print("productos $product");
    refresh();
  }
}
