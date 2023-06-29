import 'package:flutter/material.dart';
import 'package:jabes/src/login/login_page.dart';
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
      },
      theme: ThemeData(primaryColor: MyColors.primaryColor),
    );
  }
}
