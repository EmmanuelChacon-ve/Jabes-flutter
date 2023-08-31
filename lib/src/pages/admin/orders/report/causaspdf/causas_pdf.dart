import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:jabes/src/models/causes.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../utils/my_colors.dart';
import 'causas_pdf_controller.dart';

class CausasPDF extends StatefulWidget {
  const CausasPDF({super.key});

  @override
  State<CausasPDF> createState() => _CausasPDFState();
}

class _CausasPDFState extends State<CausasPDF> {
  CausasPDFController _con = new CausasPDFController();
  Uint8List? _pdfBytes;
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
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      //llamanndo al Widget _drawer() para poder ser mostrado
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Causas registrados'),
            const SizedBox(height: 20),
            _verArchivo(),
            _archivo(), // Aquí agregamos el botón _archivo al body
            if (_pdfBytes != null)
              Expanded(
                child: PDFView(
                  pdfData: _pdfBytes!,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  pageSnap: true,
                  defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  onRender: (_pages) {},
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    // Puedes guardar una referencia al controlador del PDF si lo necesitas
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _archivo() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          // Obtener la lista de usuarios
          List<Causes> causes = await _con.getAllCauses();

          // Generar el PDF
          Uint8List pdfBytes = await _con.generatePdfBytes(causes);

          // Guardar el PDF en el directorio temporal del dispositivo
          String fileName = "roles_report.pdf";
          Directory tempDir = await getTemporaryDirectory();
          String filePath = "${tempDir.path}/$fileName";
          File pdfFile = File(filePath);
          await pdfFile.writeAsBytes(pdfBytes);

          // Abrir el archivo PDF con la aplicación predeterminada
          OpenResult result = await OpenFile.open(filePath);
          print(result.message);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text('Descargar PDF'),
      ),
    );
  }

  Widget _verArchivo() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          // Obtener la lista de usuarios
          List<Causes> causas = await _con.getAllCauses();
          print('Causas obtenidas desde el backend: $causas');
          // Generar el PDF
          Uint8List pdfBytes = await _con.generatePdfBytes(causas);

          setState(() {
            _pdfBytes =
                pdfBytes; // Actualizamos los bytes del PDF en el estado para que se muestre en el visor
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text('Ver PDF en la pantalla'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
