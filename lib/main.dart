import 'package:flutter/material.dart';
import 'package:jabes/src/pages/admin/orders/list/admi_rol_page.dart';//mio
import 'package:jabes/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:jabes/src/pages/client/products/list/client_products_list_page.dart';
import 'package:jabes/src/pages/client/products/list/update/client_update_page.dart';
import 'package:jabes/src/pages/login/login_page.dart';
import 'package:jabes/src/pages/org/orders/list/org_orders_list_page.dart';
import 'package:jabes/src/pages/register/register_page.dart';
import 'package:jabes/src/pages/roles/roles_page.dart';
import 'package:jabes/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
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
        'client/products/list': (BuildContext context) => const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'org/orders/list': (BuildContext context) => const OrgOrdersListpage(),
        'admin/orders/list': (BuildContext context) => const AdminOrdersListPage(),
       'admin/orders/privileges': (BuildContext context) => const AdmiRolPage(), //constructor return
      },
      theme: ThemeData(
        fontFamily: 'Nimbusans',  
        primaryColor: MyColors.primaryColor,
      ),
    );
  }
}
