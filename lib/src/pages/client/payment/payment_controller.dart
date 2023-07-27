import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController {
  TextEditingController numericInputController = TextEditingController();

  PaymentController() {
    numericInputController = TextEditingController();
  }

  void dispose() {
    numericInputController.dispose();
  }

  void onCompleteButtonPressed(
      BuildContext context, String valor, XFile? image) {
    String numericInput = valor;
    XFile? imagen = image;
    if (numericInput.isEmpty) {
      _showSnackbar(context, 'Debes ingresar el monto a contribuir.');
      return;
    }

    if (!isNumeric(numericInput)) {
      _showSnackbar(
          context, 'El monto a contribuir debe contener solo números.');
      return;
    }

    if (image == null) {
      _showSnackbar(context, 'Debes adjuntar una captura de pantalla.');
      return;
    }

    // Procesar el monto a contribuir y realizar otras acciones aquí
    double amount = double.parse(numericInput);
    _showSnackbar(
        context, 'Monto a contribuir: \$${amount.toStringAsFixed(2)}');
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
