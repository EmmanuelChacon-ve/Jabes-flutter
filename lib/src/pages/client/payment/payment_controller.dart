import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/models/pago.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/pages/client/payment/payment_methods.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:jabes/src/utils/shared_pref.dart';

class PaymentController {
  TextEditingController numericInputController = TextEditingController();
  UsersProvider usersProvider = UsersProvider();

  PaymentController() {
    // No se necesita la inicialización duplicada de numericInputController
    // numericInputController = TextEditingController();
  }

  void dispose() {
    numericInputController.dispose();
  }

  void onCompleteButtonPressed(
    BuildContext context,
    String valor,
    XFile? image,
    String id,
    Product categoria,
  ) {
    if (valor.isEmpty) {
      _showSnackbar(context, 'Debes ingresar el monto a contribuir.');
      return;
    }

    if (!isNumeric(valor)) {
      _showSnackbar(
          context, 'El monto a contribuir debe contener solo números.');
      return;
    }

    if (image == null) {
      _showSnackbar(context, 'Debes adjuntar una captura de pantalla.');
      return;
    }

    double amount = double.parse(valor);
    _showSnackbar(
        context, 'Monto a contribuir: \$${amount.toStringAsFixed(2)}');
    subirDatos(
        amount: amount,
        imagen: image,
        id: id,
        userProvider: usersProvider,
        buildContext: context,
        categoria: categoria);

    //creando cuadro de espera
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

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}

void subirDatos({
  required double amount,
  required XFile imagen,
  required String id,
  String descripcion = 'Sin descripcion',
  required UsersProvider userProvider,
  required BuildContext buildContext,
  required Product categoria,
}) async {
  SharedPref _sharedPref = SharedPref();
  Map<String, dynamic> user = await _sharedPref.read('user');
  final User informacionUser = User.fromJson(user);

  String cantidad = amount.toStringAsFixed(2);

  File imagenConvertida = File(imagen.path);

  DateTime now = DateTime.now();

  Pagos informacionPago = Pagos(
    idPaymentMethod: id,
    amount: amount,
    nameCause: categoria.name!,
    date: now,
    description: descripcion,
    idUser: informacionUser.id!,
  );

  Stream? stream =
      await userProvider.insertPago(informacionPago, imagenConvertida);

  // Iniciar el temporizador para el tiempo de espera

  // Iniciar el temporizador al llamar a subirDatos

  stream?.listen((e) {
    // Cancelar el temporizador si el stream emite un valor antes de que ocurra el tiempo de espera
    Navigator.of(buildContext, rootNavigator: true).pop();
    ResponseApi responseApi = ResponseApi.fromJson(json.decode(e));
    if (responseApi.success!) {
      Navigator.push(
          buildContext,
          MaterialPageRoute(
              builder: (context) => MetodosPago(categoria: categoria)));
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
                  Navigator.pushNamed(context, 'client/payment/paymentMethods');
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

String formatDate(DateTime dateTime) {
  int year = dateTime.year;
  int month = dateTime.month;
  int day = dateTime.day;
  return "$year-${_addLeadingZero(month)}-${_addLeadingZero(day)}";
}

String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}
