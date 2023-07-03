import 'package:flutter/material.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';

class RegisterController {
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

    User user = User(
        email: email,
        name: name,
        lastname: apellido,
        phone: phone,
        password: password);

    ResponseApi? responseApi = await UsersProvider().create(user);

    print('Respuesta: ${responseApi?.toJson()}');
    print(email);
    print(name);
    print(apellido);
    print(phone);
    print(password);
    print(confirmPassword);
  }
}
