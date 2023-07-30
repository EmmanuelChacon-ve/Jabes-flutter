import 'package:flutter/material.dart';
import '../../../../models/user.dart';
import '../../../../utils/shared_pref.dart';
import 'package:flutter/services.dart';
import 'package:jabes/src/provider/users_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class OrgOrdersListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  final UsersProvider _usersProvider = UsersProvider();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final userData = await _sharedPref.read('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'org/categories/create');
  }

  void goToProdutsCreate() {
    Navigator.pushNamed(context, 'org/produts/create');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  Future<List<User>> getAllUsers() async {
    return _usersProvider.getAllUsers();
  }

  Future<Uint8List> generatePdfBytes(List<User> users) async {
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
                      pw.Text('Email',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Lastname',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Phone',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Filas de datos de usuarios
                  ...users.map((user) => pw.TableRow(
                        children: [
                          pw.Text(user.id!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(user.email!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(user.name!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(user.lastname!,
                              style: pw.TextStyle(font: ttf, fontSize: 18)),
                          pw.Text(user.phone!,
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
