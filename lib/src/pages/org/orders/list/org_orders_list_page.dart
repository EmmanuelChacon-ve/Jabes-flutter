import 'package:flutter/material.dart';

class OrgOrdersListpage extends StatefulWidget {
  const OrgOrdersListpage({super.key});

  @override
  State<OrgOrdersListpage> createState() => _OrgOrdersListpageState();
}

class _OrgOrdersListpageState extends State<OrgOrdersListpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Administrador orders List'),
      ),
    );
  }
}
