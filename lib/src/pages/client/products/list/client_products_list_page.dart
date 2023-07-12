import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';

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
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(), //llamanndo al Widget _drawer() para poder ser mostrado
      body: Center(
        child: ElevatedButton(
            onPressed: _con.logout, child: const Text('Cerrar Sesión')),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('asset/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre de usuario',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    'Correo Eléctronico',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    'Teléfono',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    child: const FadeInImage(
                      image: AssetImage('asset/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('asset/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Donar'),
            trailing: Icon(Icons.money),
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
