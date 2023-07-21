import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/register/register_controler.dart';

import '../../utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _con = RegisterController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(top: -90, left: -90, child: _circuloregis()),
            Positioned(
              top: 65,
              left: 27,
              child: _textregis(),
            ),
            Positioned(
              top: 52,
              left: -5,
              child: _iconback(),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 130),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    SizedBox(height: 30),
                    _email(),
                    _nombre(),
                    _apellido(),
                    _telefono(),
                    _contra(),
                    _confirmContra(),
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
            : const AssetImage('asset/img/user_profile_2.png') as ImageProvider,
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

  Widget _textregis() {
    return GestureDetector(
      onTap: _con.goTologinPage,
      child: const Text('REGISTRO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
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

  Widget _email() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
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

  Widget _contra() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _confirmContra() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar Contraseña',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _registrar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.register : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors
                .primaryColor, // Utiliza el color MyColors.primaryColor como fondo del botón
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
                vertical: 15) // Color del texto del botón
            ),
        child: const Text('Registrarse'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
