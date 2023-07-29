import 'package:flutter/material.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/container_payment.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/widget_logos.dart';
import 'package:jabes/src/utils/my_colors.dart';

class PagoBienes extends StatelessWidget {
  final String imagen;
  final String nombre;
  final String logo;
  final String id;
  const PagoBienes(
      {super.key,
      required this.imagen,
      required this.nombre,
      required this.logo,
      required this.id});
  @override
  Widget build(BuildContext context) {
    // return PaymentContainer(
    //   hijo: BienesContenido(
    //     id: id,
    //     imagen: imagen,
    //     logo: logo,
    //     nombre: nombre,
    //   ),
    // );
    return Text('data');
  }
}

class BienesContenido extends StatelessWidget {
  final String imagen;
  final String nombre;
  final String logo;
  final String id;
  const BienesContenido({
    super.key,
    required this.imagen,
    required this.nombre,
    required this.logo,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Aquí manejamos el botón de regresar
            Navigator.pushNamed(context, 'client/payment/paymentMethods');
          },
          child: const Text(
            'Regresar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontFamily: 'Nimbusans',
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagen),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        ModuloLogos(logo: logo, tipoPago: nombre),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 60,
              width: double.infinity,
              child: const Text(
                'Por favor, describe los activos',
                style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                    letterSpacing: -1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(0, 108, 53, 0.61),
              height: 250,
              width: double.infinity - 400,
            )
          ],
        )
      ],
    );
  }
}
