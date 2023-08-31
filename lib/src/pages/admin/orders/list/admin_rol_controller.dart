/* // ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/rol.dart';
import 'package:jabes/src/models/userData.dart';
import 'package:jabes/src/provider/users_provider.dart';
import '../../../../models/user.dart';
import '../../../../utils/shared_pref.dart';

class AdminRolController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  VoidCallback? refresh; // Actualizamos el tipo de refresh a VoidCallback
  User? user;
  final UsersProvider usersProvider = UsersProvider();

  List<User> usuarios = [];
  // Función para obtener los usuarios y almacenarlos en la lista
  Future<List<User>?> obtenerUsuarios() async {
    try {
      List<User> usuarios = await usersProvider.getUsuarios();
      return usuarios;
    } catch (e) {
      print('hubo un errror $e');
    }
    return null;
  }

  List<Rol> roles = [];
  // Función para obtener los usuarios y almacenarlos en la lista
  Future<List<Rol>?> obtenerRoles() async {
    try {
      List<Rol> roles = await usersProvider.getRol();
      return roles;
    } catch (e) {
      print('hubo un errror $e');
    }
    return null;
  }

  Future<void> _cargarRoles() async {
    try {
      List<Rol>? roles = await obtenerRoles();
      if (roles != null) {
        this.roles = roles;
      }
    } catch (e) {
      print('Error al cargar roles: $e');
    }
  }

  void subirCambios(
      User? selectedUser, Rol? selectedRol, BuildContext context) {
    print(selectedUser.runtimeType);
    if (selectedUser != null) {
      subirInformacion(selectedUser, selectedRol!, context);
    } else {
      _showSnackbar(context, 'No puedes dejar vacios');
      return;
    }
  }

  Future<void> init(BuildContext context, VoidCallback refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');

    if (userData != null) {
      user = User.fromJson(userData);
    }
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void gotoUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
}

void _showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

Future<void> subirInformacion(
    User usuario, Rol rol, BuildContext context) async {
  // Creando instancia de UsersProvider
  UsersProvider usersProvider = UsersProvider();
  // Creando instancia de la clase UserData
  final UserData informacion = UserData(idUser: usuario.id!, idRol: rol.id!);
  final ResponseApi? response =
      await usersProvider.insertarNuevoRol(informacion);
  _showSnackbar(context, response!.message!);
}
 */