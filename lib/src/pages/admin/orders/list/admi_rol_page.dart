import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/utils/my_colors.dart';

class AdmiRolPage extends StatelessWidget {
  const AdmiRolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrincipalContainerAdmi(),
    );
  }
}

class PrincipalContainerAdmi extends StatelessWidget {
  const PrincipalContainerAdmi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/img/imagenFondoAdmi.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.65,
          color: Colors.white,
          child: ContenidoPrincipal(),
        ),
      ),
    );
  }
}

class ContenidoPrincipal extends StatelessWidget {
  const ContenidoPrincipal({
    super.key,
  });

/*  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
        'Asignación de permisos',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
     /*Container(
          height: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom:30.0),
          child: const Text(
            'A continuación asignale los permisos necesarios al usuario:',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),*/
       SizedBox(
        width: double.infinity,
        height: 200,
        child: Container(color: Colors.amber,),
      ),
        // const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ListaDesplegable(),
         ListaDesplegable(),
        
          ],
        ),
        
        //logica para crear un button
         GreenContainer(
              container: 'Guardar permisos',
              width: 260,
              height: 60,
              padding: const EdgeInsets.all(8.0),
              onPressed: () => print("holi")
      
            ),
      ],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        height: 80,
        child: const Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Asignación de permisos',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
        )
        ],),
        ),
        Container(height: 60,
        child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
          child: Text(
        'A continuación asignale los respectivos permisos al usuario:',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  ],
),
        ),
        Container(height: 100,child: const Row(children: [ListaDesplegable(),ListaDesplegable()],mainAxisAlignment: MainAxisAlignment.spaceAround,),),
        Align(
          alignment: Alignment.bottomCenter,
          child: GreenContainer(
            container: 'Subir cambios',
            width: 180,
            height: 60,
            onPressed: () => print('qlq2'),
          ),
    )],
    );
  }
}

class ListaDesplegable extends StatefulWidget {
  const ListaDesplegable({Key? key}) : super(key: key);

  @override
  State<ListaDesplegable> createState() => _ListaDesplegableState();
}

class _ListaDesplegableState extends State<ListaDesplegable> {
  var _valorActual = 'user1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _valorActual,
      onChanged: (String? newValue) {
        setState(() {
          _valorActual = newValue!;
        });
      },
      dropdownColor: const Color.fromRGBO(0, 108, 53, 0.61),
      focusColor: Colors.transparent,
      items: const <String>['user1', 'user2', 'user3', 'user4', 'user5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
          ),
        );
      }).toList(),
    );
  }
}


  class GreenContainer extends StatelessWidget {
  final String container;
  final double? width;
  final double? height;
  //para manejar eventos onPressed
  final VoidCallback? onPressed;

  const GreenContainer(
      {Key? key,
      required this.container,
      this.width,
      this.height,
      this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          width, // Utiliza el width proporcionado o toma el ancho disponible si width es nulo
      height:
          height, // Utiliza el height proporcionado o toma el alto disponible si height es nulo
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 108, 53, 0.61),
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: onPressed, // Asignamos la función onPressed al botón
        child: Align(
          alignment: Alignment.center,
          child: Text(
            container,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}