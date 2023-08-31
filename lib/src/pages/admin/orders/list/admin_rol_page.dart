/* import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/my_colors.dart';
import 'package:jabes/src/pages/admin/orders/list/admin_rol_controller.dart';

import '../../../../models/user.dart';
import '../../../../models/rol.dart';
import '../../../../utils/shared_pref.dart';

dynamic usuarioSelect;
dynamic rolSelect;
eenojombre

class AdminRolPage extends StatefulWidget {
  const AdminRolPage({super.key});

  @override
  State<AdminRolPage> createState() => _AdminRolPageState();
}

class _AdminRolPageState extends State<AdminRolPage> {
  AdminRolController _con = new AdminRolController();

  @override
  void initState() {
    super.initState();
    _con.init(context,
        refresh); // Inicializa el controlador con el contexto y la función de actualización
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: PrincipalContainerAdmi(),
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
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.email ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.phone ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
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
                ),
              ],
            ),
          ),
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
            onTap: () =>
                Navigator.pushNamed(context, 'admin/orders/privileges'),
            title: Text('Asignar rol'),
            trailing: Icon(Icons.person_outlined),
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
    setState(() {});
  }
}

class PrincipalContainerAdmi extends StatefulWidget {
  const PrincipalContainerAdmi({
    Key? key,
  }) : super(key: key);

  @override
  State<PrincipalContainerAdmi> createState() => _PrincipalContainerAdmiState();
}

class _PrincipalContainerAdmiState extends State<PrincipalContainerAdmi> {
  AdminRolController _con = AdminRolController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/img/imagenFondoAdmi.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.65,
          color: Colors.white,
          child: FutureBuilder<List<User>?>(
            future: _con.obtenerUsuarios(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error al cargar los usuarios');
              } else {
                List<User>? usuarios = snapshot.data;
                return usuarios != null && usuarios.isNotEmpty
                    ? ContenidoPrincipal(
                        usuarios: usuarios,
                        obtenerRoles: _con.obtenerRoles,
                        con: _con, // AQUI TENGO UN ERROR
                      )
                    : Text('No se encontraron usuarios');
              }
            },
          ),
        ),
      ),
    );
  }
}

class ContenidoPrincipal extends StatefulWidget {
  final List<User>? usuarios;
  Future<List<Rol>?> Function()
      obtenerRoles; // Cambiamos el tipo de retorno de la función
  final AdminRolController con; // Agrega esta línea

  ContenidoPrincipal({
    required this.usuarios,
    required this.obtenerRoles,
    required this.con, // Agrega esta línea
  }) : roles = []; // Inicializamos la lista de roles
  List<Rol> roles; // Agregamos la lista de roles aquí

  @override
  _ContenidoPrincipalState createState() => _ContenidoPrincipalState();
}

class _ContenidoPrincipalState extends State<ContenidoPrincipal> {
  User? _selectedUser;
  Rol? _selectedRol;

  void onChangedUser(User? user) {
    setState(() {
      _selectedUser = user;
    });
  }

  void onChangedRol(Rol? rol) {
    setState(() {
      _selectedRol = rol;
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarRoles();
  }

  Future<void> _cargarRoles() async {
    try {
      List<Rol>? roles = await widget.obtenerRoles();
      if (roles != null) {
        setState(() {
          widget.roles =
              roles; // Almacenamos los roles en la lista de ContenidoPrincipal
          _selectedRol = roles[0]; // Actualizamos el rol seleccionado
        });
      }
    } catch (e) {
      print('Error al cargar roles: $e');
    }
  }

  void _subirCambios() {
    if (_selectedUser != null && _selectedRol != null) {
      print(
          'Usuario seleccionado: ${_selectedUser!.email}, ID: ${_selectedUser!.id}'); //AQUI NO SE IMPRIMIERON
      print(
          'Rol seleccionado: ${_selectedRol!.name}, ID: ${_selectedRol!.id}'); //AQUI NO SE IMPRIMIERON
    } else {
      print('Debe seleccionar un usuario y un rol');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Asignación de permisos',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 60,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'A continuación asignale los respectivos permisos al usuario:',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          child: Row(
            children: [
              if (widget.usuarios != null && widget.usuarios!.isNotEmpty)
                DropdownButtonExample(
                  users: widget.usuarios!,
                  selectedUser: _selectedUser,
                  onChangedUser: (user) {
                    setState(() {
                      _selectedUser = user;
                    });
                  },
                  roles: widget.roles,
                  selectedRol: _selectedRol,
                  onChangedRol: (rol) {
                    setState(() {
                      _selectedRol = rol;
                    });
                  },
                )
              else
                FutureBuilder<void>(
                  future: _cargarRoles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error al cargar los roles');
                    } else {
                      return Text('No hay usuarios');
                    }
                  },
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GreenContainer(
            container: 'Subir cambios',
            width: 180,
            height: 60,
            onPressed: () {
              widget.con.subirCambios(_selectedUser, _selectedRol, context);
            },
          ),
        )
      ],
    );
  }
}

class DropdownButtonExample extends StatelessWidget {
  final List<User> users;
  final User? selectedUser;
  final ValueChanged<User?> onChangedUser;
  final List<Rol> roles;
  final Rol? selectedRol;
  final ValueChanged<Rol?> onChangedRol;

  DropdownButtonExample({
    required this.users,
    required this.selectedUser,
    required this.onChangedUser,
    required this.roles,
    required this.selectedRol,
    required this.onChangedRol,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DropdownButton<User>(
            value: selectedUser,
            onChanged: onChangedUser,
            items: users.map((user) {
              return DropdownMenuItem<User>(
                value: user,
                child: Text('${user.email}, ID: ${user.id}'),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          DropdownButton<Rol>(
            value: selectedRol,
            onChanged: onChangedRol,
            items: roles.map((rol) {
              return DropdownMenuItem<Rol>(
                value: rol,
                child: Text('${rol.name}, ID: ${rol.id}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class GreenContainer extends StatelessWidget {
  final String container;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  const GreenContainer({
    Key? key,
    required this.container,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10), //aguege esto
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 108, 53, 0.61),
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            container,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
 */