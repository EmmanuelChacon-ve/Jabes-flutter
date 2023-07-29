import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/pages/org/products/create/org_produts_create_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';

class orgproductsCreatepage extends StatefulWidget {
  const orgproductsCreatepage({super.key});

  @override
  State<orgproductsCreatepage> createState() => _orgproductsCreatepageState();
}

class _orgproductsCreatepageState extends State<orgproductsCreatepage> {
  OrgProductsCreatecontroller _con = new OrgProductsCreatecontroller();

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
        title: Text('Nueva organizacion'),
        backgroundColor: MyColors.primaryColor,
/*         leading: _retorno(),  */ // Colocamos el ícono a la izquierda
      ),
      body: ListView(children: [
        SizedBox(
          height: 30,
        ),
        _produtsName(),
        _descriptionCategories(),
        Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _cardImage(_con.imageFile1, 1),
              _cardImage(_con.imageFile2, 2),
              _cardImage(_con.imageFile3, 3),
            ],
          ),
        ),
        _dropDownCategories(_con.categories),
      ]),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _buttonCreate() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors
                .primaryColor, // Utiliza el color MyColors.primaryColor como fondo del botón
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
                vertical: 15) // Color del texto del botón
            ),
        child: const Text('Crear Categoria'),
      ),
    );
  }

  Widget _produtsName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 7,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 2,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Nombre de la Organizacion',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _retorno() {
    return GestureDetector(
      onTap: _con.gotoOrderPage,
      child: Icon(
        Icons.keyboard_return_outlined,
        color: Colors.black,
      ),
    );
  }

/*   Widget _precio() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryColor2,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor2),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: MyColors.primaryColor,
            )),
      ),
    );
  } */

/*   Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Card(
              elevation: 3.0,
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image(
                  image: AssetImage('asset/img/add_image.png'),
                ),
              ),
            ),
    );
  } */

  Widget _cardImage(File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Card(
              elevation: 3.0,
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image(
                  image: AssetImage('asset/img/add_image.png'),
                ),
              ),
            ),
    );
  }

  Widget _descriptionCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 7,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 3,
        maxLength: 1000,
        decoration: InputDecoration(
            hintText: 'Descripción de la categoria',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _dropDownCategories(List<Categorys> categories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: const Text(
                    'Seleccionar categoria',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  items: _dropDownItems(categories),
                  value: _con.idCategory,
                  onChanged: (option) {
                    setState(() {
                      print('Categoria seleccionda $option');
                      _con.idCategory =
                          option; // ESTABLECIENDO EL VALOR SELECCIONADO
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Categorys> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name!),
        value: category.id,
      ));
    });

    return list;
  }

  void refresh() {
    setState(() {});
  }
}
