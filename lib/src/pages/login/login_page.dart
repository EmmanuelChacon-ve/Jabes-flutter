import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/login/login_controler.dart';
import 'package:jabes/src/utils/my_colors.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(top: -90, left: -100, child: _circulologin()),
            Positioned(
              top: 60,
              left: 25,
              child: _textlogin(),
            ),
            //este single es para que cuando se haga scroll no haga error
            SingleChildScrollView(
              child: Column(
                children: [
                  _imagenBanner(),
                  _email(),
                  _contra(),
                  _ingresar(),
                  _regis(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contra() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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

  Widget _email() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
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

  Widget _animation() {
    return Lottie.asset('asset/json/logo.json',
        width: 350, height: 200, fit: BoxFit.fill);
  }

  Widget _imagenBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          bottom: MediaQuery.of(context).size.height * 0.1),
      child: Image.asset(
        'asset/img/barco.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _ingresar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.login,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors
                .primaryColor, // Utiliza el color MyColors.primaryColor como fondo del botón
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
                vertical: 15) // Color del texto del botón
            ),
        child: const Text('Ingresar'),
      ),
    );
  }

  Widget _regis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta',
          style: TextStyle(color: MyColors.primaryColor, fontSize: 17),
        ),
        const SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          /* onTap: () {
            Navigator.pushNamed(context, 'register');
          }, ESTO TAMBIEN SE UTILIZA PARA REDIRIGIR A LA PAGINA*/
          child: Text('Registrate',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryColor,
                  fontSize: 17)),
        ),
      ],
    );
  }

  Widget _circulologin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _textlogin() {
    return const Text('LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ));
  }
}
