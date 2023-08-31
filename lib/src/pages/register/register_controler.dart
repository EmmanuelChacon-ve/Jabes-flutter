import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/my_snackbar.dart';
import 'package:flutter/scheduler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}

class RegisterController {
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UsersProvider usersProvider = UsersProvider();
  PickedFile? pickedFile;
  File? imageFile;
  late Function refresh;
  ProgressDialog? _progressDialog;
  bool isEnable = true;
  void init(BuildContext context, Function refresh) {
    this.context = context;
    usersProvider.init(context);
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
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
    if (imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;
    User user = User(
        email: email,
        name: name,
        lastname: apellido,
        phone: phone,
        password: password);

    Stream? stream = await usersProvider.createWithImage(user, imageFile);
    stream?.listen((res) {
      _progressDialog?.close();
      /* ResponseApi? responseApi = await UsersProvider().create(user); */
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      // ignore: use_build_context_synchronously
      MySnackbar.show(context, responseApi.message ?? 'Error al crear usuario');

      if (responseApi.success!) {
        Future.delayed(const Duration(seconds: 1), () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, 'login');
          });
        });
      } else {
        isEnable = true;
      }

      print('Respuesta: ${responseApi.toJson()}');
    });
  }

  Future<void> selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('Galeria'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('Camara'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
