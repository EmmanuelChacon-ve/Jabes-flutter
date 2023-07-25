import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/org/orders/list/org_orders_list_controller.dart';
import '../../../../utils/my_colors.dart';

class OrgOrdersListpage extends StatefulWidget {
  const OrgOrdersListpage({super.key});

  @override
  State<OrgOrdersListpage> createState() => _OrgOrdersListpageState();
}

class _OrgOrdersListpageState extends State<OrgOrdersListpage> {
  OrgOrdersListController _con = new OrgOrdersListController();

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
      drawer: _drawer(), //llamanndo al Widget _drawer() para poder ser mostrado
      body: const Center(
        child: Text('Organization orders List'),
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
          const ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          const ListTile(
            title: Text('Donar/Voluntariado'),
            trailing: Icon(Icons.volunteer_activism),
          ),
          const ListTile(
            title: Text('Registro de donaciones'),
            trailing: Icon(Icons.picture_as_pdf),
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
