import 'package:flutter/material.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/my_snackbar.dart';
import 'package:flutter/scheduler.dart';

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}

class ClientUpdateController {
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void init(BuildContext context) {
    this.context = context;
  }

  void goTologinPage() {
    Navigator.pushNamed(context, 'login');
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String apellido = apellidoController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        apellido.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar Todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(context, 'La contraseña debe tener mas de 6 caracteres');
      return;
    }

    if (!isNumeric(phone)) {
      MySnackbar.show(
          context, 'El número de teléfono debe contener solo numeros');
      return;
    }
    User user = User(
        email: email,
        name: name,
        lastname: apellido,
        phone: phone,
        password: password);

    ResponseApi? responseApi = await UsersProvider().create(user);

    // ignore: use_build_context_synchronously
    MySnackbar.show(context, responseApi?.message ?? 'Error al crear usuario');

    if (responseApi != null &&
        responseApi.success != null &&
        responseApi.success!) {
      Future.delayed(const Duration(seconds: 1), () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, 'login');
        });
      });
    }

    print('Respuesta: ${responseApi?.toJson()}');
  }
}
