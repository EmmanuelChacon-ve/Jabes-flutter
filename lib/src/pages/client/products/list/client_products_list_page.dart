import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _con = ClientProductsListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(), //llamanndo al Widget _drawer() para poder ser mostrado
      body: Center(
        child: ElevatedButton(
            onPressed: _con.logout, child: const Text('Cerrar Sesión')),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: () {}, //QUEDE AQUI... NO TOCAR   BY: YURI
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Text(
                'Nombre de usuario',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              )
            ],
          ))
        ],
      ),
    );
  }
}
