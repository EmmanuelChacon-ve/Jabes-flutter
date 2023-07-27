import 'package:flutter/material.dart';
// import '../utils/IconPaths.dart';

class MetodosPago extends StatelessWidget {
  const MetodosPago({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
  const ListMethods({Key? key}) : super(key: key);

  final List<Map<String, String>> methods = const [
    {'nombre': 'Pagos Digitales', 'urlImagen': 'asset/img/method1.png'},
    {'nombre': 'Cripto Monedas', 'urlImagen': 'asset/img/method2.png'},
    {'nombre': 'Cesion de bienes', 'urlImagen': 'asset/img/method3.png'},
    {'nombre': 'Voluntariado', 'urlImagen': 'asset/img/method4.png'},
    {'nombre': 'Insumos', 'urlImagen': 'asset/img/method5.png'},
    {'nombre': 'Legado', 'urlImagen': 'asset/img/method6.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      itemCount: methods.length,
      itemBuilder: (context, index) {
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
            MethodsOptions(methodData: methods[index]),
          ],
        );
      },
    );
  }
}

class MethodsOptions extends StatelessWidget {
  final Map<String, String> methodData;

  const MethodsOptions({
    Key? key,
    required this.methodData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //pasar methodData como variable para obtener valor de donde esta la imagen y id para el json
      onTap: () => print(methodData),
      leading: const CircleAvatar(child: FlutterLogo()),
      title: Text(
        //aqui manejar de mejor forma el ''
        methodData['nombre'] ?? '',
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}
