import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/admin/orders/list/admin_orders_list_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';

class AdminOrdersListPage extends StatefulWidget {
  const AdminOrdersListPage({super.key});

  @override
  State<AdminOrdersListPage> createState() => _AdminOrdersListPageState();
}

class _AdminOrdersListPageState extends State<AdminOrdersListPage> {
  AdminOrdersListController _con = new AdminOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
        backgroundColor: MyColors.primaryColor,
      ),
      drawer: _drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '¡Bienvenido ${_con.user?.name ?? ''}!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Disfruta de la experiencia Jabes',
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aquí podrás ver tus órdenes y más.',
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Center(
            child: Text(
              'Chequea tus PDFS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
              ),
            ),
          ),
        ],
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
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
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
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image as String)
                          : const AssetImage('asset/img/no-image.png')
                              as ImageProvider<Object>,
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('asset/img/no-image.png'),
                    ),
                  )
                ],
              )),
/*           const ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ), */
          ListTile(
            onTap: _con.goToPDF,
            title: const Text('Reportes en PDF'),
            trailing: const Icon(Icons.picture_as_pdf),
          ),
          ListTile(
            onTap: _con.goToRoles,
            title: const Text('Seleccionar rol'),
            trailing: const Icon(Icons.person_outlined),
          ),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(
        () {}); //CTRL + S = REDIBUJAR TODO CUANDO EL USER YA ESTE CARGADO( )
  }
}
