import 'package:flutter/material.dart';
import '../../../../utils/shared_pref.dart';

class ClientProductsListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  void init(BuildContext context) {
    this.context = context;
  }

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }
}
