import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/client/products/list/update/client_update_controller.dart';

import '../../../../../utils/my_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  final ClientUpdateController _con = ClientUpdateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  // _textVolverEditar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(top: -90, left: -90, child: _circuloregis()),
            Positioned(
              top: 52,
              left: -5,
              child: _iconback(),
            ),
            Positioned(
              top: 65,
              left: 27,
              child: _textVolverEditar(), //Texto para volver al menu
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 130),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    SizedBox(height: 30),
                    _nombre(),
                    _apellido(),
                    _telefono(),
                    _registrar()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        // ignore: unnecessary_null_comparison
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile!)
            : _con.user?.image != null
                ? NetworkImage(_con.user!.image!)
                : const AssetImage('asset/img/user_profile_2.png')
                    as ImageProvider,
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _circuloregis() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _iconback() {
    return IconButton(
        onPressed: _con.goTologinPage,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ));
  }

  Widget _nombre() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _apellido() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.apellidoController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _telefono() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'telefono',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textVolverEditar() {
    return const Text('Volver',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ));
  }

  Widget _registrar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          _con.update();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors
                .primaryColor, // Utiliza el color MyColors.primaryColor como fondo del botón
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
                vertical: 15) // Color del texto del botón
            ),
        child: const Text('ACTUALIZAR PERFIL'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
