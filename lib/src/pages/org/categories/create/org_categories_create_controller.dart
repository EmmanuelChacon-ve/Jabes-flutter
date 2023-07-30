import 'package:flutter/material.dart';
import 'package:jabes/src/models/response_api.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/provider/category_provider.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import '../../../../utils/my_snackbar.dart';

class OrgCategoriesCreatecontroller {
  late BuildContext context;
  Function? refresh;
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();
  User? user;
  SharedPref sharedPref = SharedPref();

  void init(BuildContext context, Function? refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    categoriesProvider.init(context, user!);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    // Crea un objeto Categorys con el nombre y la descripción
    Categorys category = Categorys(name: name, description: description);

    // Llama a la función de CategoriesProvider para crear la categoría
    ResponseApi? responseApi = await categoriesProvider.create(category);

    // Muestra el mensaje de respuesta del servidor
    MySnackbar.show(context, responseApi!.message!);

    // Si la creación fue exitosa, limpia los campos de texto
    if (responseApi.success!) {
      nameController.text = '';
      descriptionController.text = '';
    }

    print('nombre: $name');
    print('descripcion $description');
  }

  void gotoOrderPage() {
    Navigator.pushNamedAndRemoveUntil(
        context, 'org/orders/list', (route) => false);
  }
}
