import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/org/orders/list/org_orders_list_controller.dart';
import '../../../../models/user.dart';
import '../../../../utils/my_colors.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class OrgOrdersListpage extends StatefulWidget {
  const OrgOrdersListpage({super.key});

  @override
  State<OrgOrdersListpage> createState() => _OrgOrdersListpageState();
}

class _OrgOrdersListpageState extends State<OrgOrdersListpage> {
  OrgOrdersListController _con = new OrgOrdersListController();
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
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
        backgroundColor: MyColors.primaryColor,
      ),
      drawer: _drawer(), //llamanndo al Widget _drawer() para poder ser mostrado
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyColors.primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '¡Bienvenido ${_con.user?.name ?? ''}!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Disfruta de la experiencia Jabes',
              style: TextStyle(
                fontSize: 18,
                color: MyColors.primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aquí podrás hacer tus categorias y causas y más.',
              style: TextStyle(
                fontSize: 16,
                color: MyColors.primaryColor,
              ),
            ),
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

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('asset/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image as String)
                          : const AssetImage('asset/img/no-image.png')
                              as ImageProvider<Object>,
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('asset/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: _con.goToRoles,
            title: const Text('Seleccionar Rol'),
            trailing: const Icon(Icons.person_3_outlined),
          ),
          ListTile(
            onTap: _con.goToCategoryCreate,
            title: const Text('Crear Categoria'),
            trailing: const Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.goToProdutsCreate,
            title: const Text('Crear Organizacion'),
            trailing: const Icon(Icons.outdoor_grill_outlined),
          ),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.power_settings_new),
          ),
        ],
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
          List<User> users = await _con.getAllUsers();

          // Generar el PDF
          Uint8List pdfBytes = await _con.generatePdfBytes(users);

          // Guardar el PDF en el directorio temporal del dispositivo
          String fileName = "users_report.pdf";
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
          List<User> users = await _con.getAllUsers();

          // Generar el PDF
          Uint8List pdfBytes = await _con.generatePdfBytes(users);

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
    setState(
        () {}); //CTRL + S = REDIBUJAR TODO CUANDO EL USER YA ESTE CARGADO( )
  }
}
