import 'package:flutter/material.dart';
import 'package:jabes/src/pages/login/login_page.dart';
import 'package:jabes/src/pages/register/register_page.dart';
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
      },
      theme: ThemeData(
          fontFamily: 'Nimbusans', primaryColor: MyColors.primaryColor),
    );
  }
}
