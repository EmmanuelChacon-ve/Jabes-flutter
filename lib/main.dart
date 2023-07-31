import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:jabes/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:jabes/src/pages/admin/orders/report/admin_report_page.dart';
import 'package:jabes/src/pages/admin/orders/report/categoriaspdf/categoria_pdf.dart';
import 'package:jabes/src/pages/admin/orders/report/causaspdf/causas_pdf.dart';
import 'package:jabes/src/pages/admin/orders/report/haspdf/has_pdf.dart';
import 'package:jabes/src/pages/admin/orders/report/rolespdf/roles_pdf.dart';
import 'package:jabes/src/pages/admin/orders/report/userpdf/user_pdf.dart';

import 'package:jabes/src/pages/client/products/list/client_products_list_page.dart';
import 'package:jabes/src/pages/client/products/list/update/client_update_page.dart';
import 'package:jabes/src/pages/login/login_page.dart';
import 'package:jabes/src/pages/org/categories/create/org_categories_create_page.dart';
import 'package:jabes/src/pages/org/orders/list/org_orders_list_page.dart';
import 'package:jabes/src/pages/org/products/create/org_produts_create_page.dart';
import 'package:jabes/src/pages/register/register_page.dart';
import 'package:jabes/src/pages/roles/roles_page.dart';
import 'package:jabes/src/utils/my_colors.dart';

import 'package:intl/date_symbol_data_local.dart' as tiempo;

void main() {
  //necesario para iniciar los modulos de intl encargado de formatear la fecha en formato estandar
  tiempo.initializeDateFormatting().then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jabes',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) =>
            const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'org/orders/list': (BuildContext context) => const OrgOrdersListpage(),
        'org/categories/create': (BuildContext context) =>
            const orgCategoriesCreatepage(),
        'org/produts/create': (BuildContext context) =>
            const orgproductsCreatepage(),
        'admin/orders/list': (BuildContext context) =>
            const AdminOrdersListPage(),
        'admin/orders/report': (BuildContext context) =>
            const AdminReportPage(),
        'admin/orders/report/userPDF': (BuildContext context) =>
            const userPDF(),
        'admin/orders/report/RolesPDF': (BuildContext context) =>
            const RolesPDF(),
        'admin/orders/report/hasPDF': (BuildContext context) => const hasPDF(),
        'admin/orders/report/CausasPDF': (BuildContext context) =>
            const CausasPDF(),
        'admin/orders/report/CategoryPDF': (BuildContext context) =>
            const CategoryPDF(),
      },
      theme: ThemeData(
          fontFamily: 'Nimbusans',
          primaryColor: MyColors.primaryColor,
          appBarTheme: const AppBarTheme(elevation: 0)),
    );
  }
}
