import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/models/pago.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/provider/products_provider.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/shared_pref.dart';

class BienesContenidoController {
  //crenado patron singleton para manejar una sola instancia y de esta forma cuando se desmonte borrar los valores albergados
  static final BienesContenidoController _instance =
      BienesContenidoController._internal();

  factory BienesContenidoController() {
    return _instance;
  }
//
  BienesContenidoController._internal();
  //
  TextEditingController texto = TextEditingController();
  //para el comentario
  String descripcion = '';
  //para la imagen
  XFile? selectedImage;
  //
  UsersProvider usersProvider = UsersProvider();
  //creando metodos set para capturar los valores
  void setDescripcion(String valor) {
    descripcion = valor;
  }

  void setImagen(XFile? imagen) {
    selectedImage = imagen;
  }

  //limpiar data
  void limpiar() {
    descripcion = '';
    selectedImage = null;
  }
  //

  void onPressedButton(BuildContext context, String id, Product categoria) {
    //si esta vacio el input
    if (descripcion == '') {
      _showSnackbar(
          context, 'Debes ingresar Una descripcion del Bien a donar.');
      return;
    }

    if (selectedImage == null) {
      _showSnackbar(context, 'Debes adjuntar una captura de pantalla.');
      return;
    }
    subirDatos(
        descripcion: descripcion,
        imagen: selectedImage!,
        id: id,
        userProvider: usersProvider,
        buildContext: context,
        categoria: categoria);

    showDialog(
      context: context,
      barrierDismissible:
          false, // Impide que se cierre tocando fuera del cuadro de carga
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              SpinKitPumpingHeart(
                  color: Color.fromARGB(
                      255, 10, 131, 230)), // Spinkit CircularProgress
              SizedBox(width: 20),
              Text("Cargando..."),
            ],
          ),
        );
      },
    );
  }
}

void _showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

//metodo para subir datos
void subirDatos({
  required String descripcion,
  required XFile imagen,
  required String id,
  required UsersProvider userProvider,
  required BuildContext buildContext,
  required Product categoria,
}) async {
  SharedPref _sharedPref = SharedPref();
  Map<String, dynamic> user = await _sharedPref.read('user');
  final User informacionUser = User.fromJson(user);
  File imagenConvertida = File(imagen.path);

  DateTime now = DateTime.now();

  Pagos informacionPago = Pagos(
    idPaymentMethod: id,
    amount: 0,
    nameCause: categoria.name!,
    date: now,
    description: descripcion,
    idUser: informacionUser.id!,
  );

  Stream? stream =
      await userProvider.insertPago(informacionPago, imagenConvertida);

  final Duration timeOutDuration = Duration(seconds: 5);
  Timer? timer;
  // Iniciar el temporizador para el tiempo de espera
  void startTimer() {
    timer = Timer(timeOutDuration, () {
      // Si entra en esta función, significa que ha ocurrido el tiempo de espera
      // Cerrar el cuadro de carga
      Navigator.of(buildContext, rootNavigator: true).pop();

      // Mostrar el cuadro de diálogo de error de tiempo de espera
      showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Tiempo de espera agotado. Inténtalo nuevamente."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'client/products/list');
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  // Iniciar el temporizador al llamar a subirDatos
  startTimer();

  stream?.listen((e) {
    // Cancelar el temporizador si el stream emite un valor antes de que ocurra el tiempo de espera
    timer?.cancel();
    Navigator.of(buildContext, rootNavigator: true).pop();
    ResponseApi responseApi = ResponseApi.fromJson(json.decode(e));
    if (responseApi.success!) {
      Navigator.pushNamed(buildContext, 'client/products/list');
      BienesContenidoController borrar = BienesContenidoController();
      borrar.limpiar();
    } else {
      // Mostrar cuadro de diálogo con el mensaje "Intenta más tarde"
      showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Inténtalo más tarde."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'client/products/list');
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  });
}

  //metodo para limpiar despues de enviar peticion
