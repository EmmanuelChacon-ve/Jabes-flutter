import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jabes/src/pages/client/payment/widgets_payment/green_container.dart';

class ModuleOrganizacion extends StatelessWidget {
  const ModuleOrganizacion({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE dd/MM/yyyy', 'es');
    final formattedDate = formatter.format(now);

    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Column(
        children: [
          const GreenContainer(
            //implementar cuando la persona ya haya seleccionado una organizacion
            container: 'Christian Science Latam',
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
