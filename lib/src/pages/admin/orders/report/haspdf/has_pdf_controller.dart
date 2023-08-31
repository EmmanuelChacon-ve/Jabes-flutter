import 'package:flutter/material.dart';
import '../../../../../models/userhasroles.dart';
import '../../../../../utils/shared_pref.dart';
import 'package:flutter/services.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class HasPDFController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  UserHasRoles? rolhas;
  final UsersProvider _usersProvider = UsersProvider();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');
    if (userData != null) {
      rolhas = UserHasRoles.fromJson(userData);
    }
    refresh();
  }

  Future<List<UserHasRoles>> getAlluser_has_roles() async {
    return _usersProvider.getAlluser_has_roles();
  }

  Future<Uint8List> generatePdfBytes(List<UserHasRoles> roleshas) async {
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
                  1: pw.FixedColumnWidth(160),
                  3: pw.FixedColumnWidth(70), // Ancho fijo de 30 puntos
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
                      pw.Text('ID de Usuario',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('ID del Rol',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Filas de datos de usuarios
                  ...roleshas.map((rolhas) => pw.TableRow(
                        children: [
                          pw.Text(rolhas.id!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(rolhas.userId!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(rolhas.roleId!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
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
