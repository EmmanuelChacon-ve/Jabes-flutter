import 'package:flutter/material.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/my_snackbar.dart';
import 'package:jabes/src/utils/shared_pref.dart';

import '../../models/response_api.dart';

class LoginController {
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  final SharedPref _sharedPref = SharedPref();

  void init(BuildContext context) async {
    this.context = context;
    usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print('Usuario: ${user.toJson()}');
    if (user.sessionToken != null) {
      if (user.roles!.length > 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles![0].route!, (route) => false);
      }
    } /* else {
      MySnackbar.show(context, 'El usuario ya esta logeado');
      return;
    } */
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi? responseApi = await usersProvider.login(email, password);
    print('Respuesta: ${responseApi?.toJson()}');
    if (responseApi!.success!) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      print('Usuario logeado:  ${user.toJson()}');
      if (user.roles!.length > 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            // este pushNamedAndRemoveUntil nos permite que si le damos para atras al telefono no haya mas paginas guardadas  y se sale de la aplicacion , es decir para que el usuario quiera ir otra vez a iniciar seccion tiene que  hacer el logout
            context,
            'roles',
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          user.roles?[0].route ?? '',
          (route) => false,
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      MySnackbar.show(context, responseApi.message ?? 'Error al Ingresar');
    }

    print('Respuesta: ${responseApi.toJson()}');
    print('Email : $email');
    print('Contraseña : $password');
  }
}
