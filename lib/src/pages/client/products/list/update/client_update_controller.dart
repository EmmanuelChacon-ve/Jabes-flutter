import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/my_snackbar.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}

//Controlador de editar perfil
class ClientUpdateController {
  late BuildContext context;
  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  late Function refresh;
  ProgressDialog? _progressDialog;

  bool isEnable = true;
  User? user;
  SharedPref _sharedPref = new SharedPref();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    nameController.text = user!.name!;
    apellidoController.text = user!.lastname!;
    phoneController.text = user!.phone!;

    refresh();
  }

  void goTologinPage() {
    Navigator.pushNamed(context, 'login');
  }

  void update() async {
    String name = nameController.text;
    String apellido = apellidoController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || apellido.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar Todos los campos');
      return;
    }

    if (!isNumeric(phone)) {
      MySnackbar.show(
          context, 'El número de teléfono debe contener solo numeros');
      return;
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;

    User myuser = User(
        id: user!.id,
        // email: user!.email,
        name: name,
        lastname: apellido,
        phone: phone,
        image: user!.image);

    // password: password);

    Stream? stream = await usersProvider.update(myuser, imageFile);
    stream?.listen((res) async {
      _progressDialog?.close();
      /* ResponseApi? responseApi = await UsersProvider().create(user); */
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message!);

      if (responseApi.success!) {
        user = await usersProvider
            .getById(myuser.id!); //obteniendo el usuario en la base de datos
        _sharedPref.save('user', myuser.toJson());
        Navigator.restorablePushNamedAndRemoveUntil(
            context, 'client/products/list', (route) => false);
      } else {
        isEnable = true;
      }
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
