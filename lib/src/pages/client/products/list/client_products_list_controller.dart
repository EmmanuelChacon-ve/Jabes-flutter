import 'package:flutter/material.dart';

import '../../../../utils/shared_pref.dart';

class ClientProductsListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  void init(BuildContext context) {
    this.context = context;
  }

  logout() {
    _sharedPref.logout(context);
  }
}
