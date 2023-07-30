import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/green_container.dart';

class ModuleOrganizacion extends StatelessWidget {
  final String nombre;
  const ModuleOrganizacion({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE dd/MM/yyyy', 'es');
    final formattedDate = formatter.format(now);

    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Column(
        children: [
          GreenContainer(
            //implementar cuando la persona ya haya seleccionado una organizacion
            container: '$nombre',
            height: 40,
          ),
          GreenContainer(
            container: formattedDate,
            height: 40,
          ),
        ],
      ),
    );
  }
}
