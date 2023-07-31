import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/pages/client/payment/payment_controller.dart';
import 'package:jabes/src/pages/client/payment/payment_controller_other.dart';
import 'package:jabes/src/pages/client/payment/payment_methods.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/boton_imagen.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/container_payment.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/green_container.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/module_organizacion.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/widget_logos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//variable global
XFile? imagenGlobal;
late String idPayment;

//
class Prueba extends StatelessWidget {
  //imagen a mostrar en el principio de la vista
  final String imagen;
  final String nombre;
  final String logo;
  final String id;
  final Product categoria;
  Prueba({
    Key? key,
    this.imagen = "asset/img/no-image.png",
    this.nombre = 'Ah ocurrido un error',
    this.logo = 'asset/img/no-image.png',
    required this.id,
    required this.categoria,
  }) : super(key: key) {
    idPayment = id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentContainer(
        hijo: BienesContenido(
          imagen: imagen,
          logo: logo,
          nombre: nombre,
          id: id,
          categoria: categoria,
        ),
      ),
    );
  }
}

class BienesContenido extends StatelessWidget {
  final String imagen;
  final String nombre;
  final String logo;
  final String id;
  final Product categoria;
  const BienesContenido({
    super.key,
    required this.imagen,
    required this.nombre,
    required this.logo,
    required this.id,
    required this.categoria,
  });
  @override
  Widget build(BuildContext context) {
    final BienesContenidoController controller = BienesContenidoController();
    final String texto = id == '5'
        ? 'Estimado contribuyente, solo podemos administrar donaciones de insumos a causas que se encuentren en tu misma ciudad.Por favor, describa  los insumos, ciudad y disponibilidad de recepción:'
        : 'Escribe aqui...';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MetodosPago(categoria: categoria))),
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
          height: 85,
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
              margin: const EdgeInsets.only(top: 8),
              height: 20,
              width: double.infinity,
              child: const Text(
                'Por favor, describe los activos',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 17,
                  letterSpacing: -1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              // Utilizamos SizedBox para proporcionar una altura específica
              height: 120, // Ajusta la altura según tus necesidades
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                color: const Color.fromRGBO(0, 108, 53, 0.61),
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: InputTexto(controller: controller, texto: texto),
                ),
              ),
            ),
            ModuleOrganizacion(nombre: categoria.name!),
            ContainerFoto(controller: controller),
            GreenContainer(
              container: 'Completar',
              width: 300,
              height: 60,
              onPressed: () {
                controller.onPressedButton(context, id, categoria);
                //traer informacion
                // PaymentController controlador = PaymentController();
              },
            )
          ],
        )
      ],
    );
  }
}

class InputTexto extends StatelessWidget {
  const InputTexto({
    Key? key,
    required this.controller,
    required this.texto,
  }) : super(key: key);

  final BienesContenidoController controller;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        controller.setDescripcion(value); // Update the descripcion property
      },
      style: const TextStyle(color: Colors.white),
      controller: TextEditingController(
        text: controller.descripcion, // Set the initial value of the TextField
      ),
      maxLines: null, // Permite múltiples líneas de texto.
      decoration: InputDecoration(
        hintText: texto,
        hintMaxLines: 6,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
