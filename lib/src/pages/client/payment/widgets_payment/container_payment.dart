import 'package:flutter/material.dart';
import 'package:jabes/src/utils/my_colors.dart';

final ThemeData paymentTheme = ThemeData(
  fontFamily: 'Nimbusans',
  primaryColor: MyColors.primaryColor,
);

class PaymentContainer extends StatelessWidget {
  final String urlImagen = 'asset/img/fondoP.png';
  final Widget hijo;

  const PaymentContainer({Key? key, required this.hijo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: paymentTheme,
      child: Container(
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
            child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.90,
              child: OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: MediaQuery.of(context).size.height - 110,
                child: Padding(
                  padding: const EdgeInsets.all(
                      //si se encuentra overflow corregir este padding
                      0.0),
                  child: hijo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
