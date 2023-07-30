import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/models/user.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/provider/category_provider.dart';
import 'package:jabes/src/provider/products_provider.dart';
import 'package:jabes/src/utils/shared_pref.dart';
import 'package:jabes/src/models/product.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../../../models/response_api.dart';
import '../../../../utils/my_snackbar.dart';

class OrgProductsCreatecontroller {
  late BuildContext context;
  Function? refresh;
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
/*   TextEditingController priceController = new TextEditingController(); */

  CategoriesProvider categoriesProvider = CategoriesProvider();
  User? user;
  SharedPref sharedPref = SharedPref();
  List<Categorys> categories = [];
  String? idCategory;

  //imagenes

  PickedFile? pickedFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  ProgressDialog? progressDialog;
  ProductsProvider productsProvider = ProductsProvider();
  void init(BuildContext context, Function? refresh) async {
    this.context = context;
    this.refresh = refresh;
    progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    categoriesProvider.init(context, user!);
    productsProvider.init(context, user!);

    getCategories();
  }

  void getCategories() async {
    categories = await categoriesProvider.getAll();
    refresh!();
  }

  void gotoOrderPage() {
    Navigator.pushNamedAndRemoveUntil(
        context, 'org/orders/list', (route) => false);
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;

    /*   double price = double.parse(priceController.text); */

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las tres imagenes');
      return;
    }
    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona la categoria del producto');
      return;
    }

    Product product = Product(
        name: name,
        description: description,
        idCategory: int.parse(idCategory!));

    List<File> images = [];
    images.add(imageFile1!);
    images.add(imageFile2!);
    images.add(imageFile3!);

    // Obtener el id_user del usuario logueado desde el objeto user
    String id_user = user!.id!;

    progressDialog!.show(max: 100, msg: 'Espere un momento');
    Stream? stream = await productsProvider.create(product, images, id_user);
    stream!.listen((res) {
      progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message!);

      if (responseApi.success!) {
        resetValues();
      }
      refresh!();
    });

    print('Formulario : ${product.toJson()}');
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refresh!();
  }

  Future<void> selectImage(ImageSource imageSource, int numberFile) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.pop(context);
    refresh!();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
