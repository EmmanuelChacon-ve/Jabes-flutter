import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:jabes/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:jabes/src/pages/client/payment/individual_pago.dart';
import 'package:jabes/src/pages/client/payment/payment_methods.dart';
import 'package:jabes/src/pages/client/products/list/client_products_list_page.dart';
import 'package:jabes/src/pages/login/login_page.dart';
import 'package:jabes/src/pages/org/orders/list/org_orders_list_page.dart';
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
        'org/orders/list': (BuildContext context) => const OrgOrdersListpage(),
        'admin/orders/list': (BuildContext context) =>
            const AdminOrdersListPage(),
        'client/payment/paymentMethods': (BuildContext context) =>
            const MetodosPago(),
        'client/payment/individual': (BuildContext context) => PagoIndividual(),
      },
      theme: ThemeData(
        fontFamily: 'Nimbusans',
        primaryColor: MyColors.primaryColor,
      ),
    );
  }
}
