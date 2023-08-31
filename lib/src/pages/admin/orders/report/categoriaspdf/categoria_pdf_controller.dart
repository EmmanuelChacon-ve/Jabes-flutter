import 'package:flutter/material.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/models/causes.dart';
import '../../../../../provider/users_provider.dart';
import '../../../../../utils/shared_pref.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class CategorysPDFController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  Categorys? categorys;
  final UsersProvider _usersProvider =
      UsersProvider(); // Agrega una instancia del proveedor

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');
    if (userData != null) {
      categorys = Categorys.fromJson(userData);
      // Inicializa el proveedor con el contexto y el usuario de la sesión
    }
    refresh();
  }

  Future<List<Categorys>> getAllCategoria() async {
    return _usersProvider.getAllCategoria();
  }

  Future<Uint8List> generatePdfBytes(List<Categorys> categorias) async {
    final pdf = pw.Document();

    // Cargamos la fuente Roboto desde el archivo ttf
    final fontData =
        await rootBundle.load('asset/fonts/Roboto/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.ListView.builder(
            itemCount: 1, // Creamos una sola lista con la tabla
            itemBuilder: (context, index) {
              return pw.Table(
                border: pw.TableBorder.all(),
                defaultColumnWidth: pw
                    .FlexColumnWidth(), // Ajustamos el ancho de columna automáticamente
                // Definimos el ancho de la primera columna (ID)
                columnWidths: {
                  0: pw.FixedColumnWidth(30),
                  1: pw.FixedColumnWidth(60),
                  2: pw.FixedColumnWidth(30), // Ancho fijo de 30 puntos
                },
                children: [
                  // Fila de encabezados
                  pw.TableRow(
                    children: [
                      pw.Text('ID',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Nombre de la causa',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
/*                       pw.Text('Id de Categoria',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)), */
/*                       pw.Text('Nombre de la Causa',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Descripcion de la Causa',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)), */
                    ],
                  ),
                  // Filas de datos de usuarios
                  ...categorias.map((categorys) => pw.TableRow(
                        children: [
                          pw.Text(categorys.id!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(categorys.name!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
/*                           pw.Text(categorys.description!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)), */
/*                           pw.Text(protuct.name!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(protuct.description!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)), */
                        ],
                      )),
                ],
              );
            },
          );
        },
      ),
    );

    return pdf.save();
  }
}
