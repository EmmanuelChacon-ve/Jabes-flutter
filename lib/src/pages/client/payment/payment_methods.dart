import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jabes/src/models/payment.dart';
import 'package:jabes/src/pages/client/payment/individual_pago.dart';
import '../../../provider/users_provider.dart';
// import '../../../models/response_api.dart';

class Informacion {
  Future<List<dynamic>> init() async {
    final response = await UsersProvider().metodosDePago();
    List<dynamic> paymentList = response.map((jsonObject) {
      return Payment.fromJson(jsonObject);
    }).toList();
    return paymentList;
  }
}

//agregar drawer y menuDrawer
//manejando vista por el momento solo logica en el front
//ya qeu se maneja una sola funcion

class MetodosPago extends StatelessWidget {
  const MetodosPago({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrincipalContainer(hijo: ListMethods()),
    );
  }
}

class PrincipalContainer extends StatelessWidget {
  final String urlImagen = 'asset/img/fondoP.png';
  final Widget hijo;
  const PrincipalContainer({Key? key, required this.hijo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(urlImagen),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.90,
          color: Colors.white,
          child: hijo,
        ),
      ),
    );
  }
}

class ListMethods extends StatelessWidget {
  final List<Map<String, String>> methods = const [
    {'nombre': 'Pagos Digitales', 'urlImagen': 'asset/img/method1.png'},
    {'nombre': 'Legado', 'urlImagen': 'asset/img/method6.png'},
    {'nombre': 'Cesion de bienes', 'urlImagen': 'asset/img/method3.png'},
    {'nombre': 'Voluntariado', 'urlImagen': 'asset/img/method4.png'},
    {'nombre': 'Insumos', 'urlImagen': 'asset/img/method5.png'},
    {'nombre': 'Cripto Monedas', 'urlImagen': 'asset/img/method2.png'},
  ];

  final Informacion informacion = Informacion();

  ListMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: informacion.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Error al obtener los métodos de pago.'));
        } else {
          List<dynamic> paymentList = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 25),
            itemCount: paymentList.length,
            itemBuilder: (context, index) {
              Payment payment = paymentList[index];
              //nombres
              List<String> appNames = payment.selectorIdPaymentType
                  .map((selector) => selector.nombre)
                  .toList();
              //imagenes
              List<String> appImage = payment.selectorIdPaymentType
                  .map((selector) => selector.imagen)
                  .toList();
              return ExpansionTile(
                trailing: null,
                title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(methods[index]['urlImagen']!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                children: [
                  MethodsOptions(
                    appNames: appNames,
                    appImage: appImage,
                    imagen: methods[index]['urlImagen']!,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class MethodsOptions extends StatelessWidget {
  final List<String> appNames;
  final List<String> appImage;
  final String imagen;

  const MethodsOptions({
    Key? key,
    required this.appNames,
    required this.appImage,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(appNames.length, (index) {
        //nombre del pago actual
        String appName = appNames[index];
        //url de la imagen
        String imagePath = appImage[index];

        return ListTile(
          //a diferencia de pushNamed este permite el elemento que deseo crear ideal para pasar la propiedad imagen
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PagoIndividual(
                        imagen: imagen,
                        nombre: appName,
                        logo: imagePath,
                      ))),
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            appName,
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        );
      }).toList(),
    );
  }
}
