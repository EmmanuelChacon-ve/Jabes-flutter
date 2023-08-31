import 'package:flutter/material.dart';
import '../../../../models/user.dart';
import '../../../../utils/shared_pref.dart';

class AdminReportController {
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

  void goToUserPDF() {
    Navigator.pushNamed(context, 'admin/orders/report/userPDF');
  }

  void goToRolesPDF() {
    Navigator.pushNamed(context, 'admin/orders/report/RolesPDF');
  }

  void goToCausasPDF() {
    Navigator.pushNamed(context, 'admin/orders/report/CausasPDF');
  }

  void goToCategoriasPDF() {
    Navigator.pushNamed(context, 'admin/orders/report/CategoryPDF');
  }

  void goToHasPDF() {
    Navigator.pushNamed(context, 'admin/orders/report/hasPDF');
  }
}
