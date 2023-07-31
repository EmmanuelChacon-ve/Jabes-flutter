import 'package:flutter/material.dart';
import 'package:jabes/src/pages/client/payment/individual_pago.dart';

class ModuloLogos extends StatelessWidget {
  final String logo;
  final String tipoPago;

  ModuloLogos({required this.logo, required this.tipoPago});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(logo),
        ),
        GreenContainer(
          container: tipoPago,
          width: 270,
          height: 40,
        ),
      ],
    );
  }
}
