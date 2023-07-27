import 'package:flutter/material.dart';
import '../../../../models/user.dart';
import '../../../../utils/shared_pref.dart';

class OrgOrdersListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }
}