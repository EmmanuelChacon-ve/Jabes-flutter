import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/pages/org/categories/create/org_categories_create_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';

class orgCategoriesCreatepage extends StatefulWidget {
  const orgCategoriesCreatepage({super.key});

  @override
  State<orgCategoriesCreatepage> createState() =>
      _orgCategoriesCreatepageState();
}

class _orgCategoriesCreatepageState extends State<orgCategoriesCreatepage> {
  OrgCategoriesCreatecontroller _con = new OrgCategoriesCreatecontroller();

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
        title: Text('Nueva categoria'),
        backgroundColor: MyColors.primaryColor,
/*         leading: _retorno(), */
      ),
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        _categoriName(),
        _descriptionCategories(),
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
        onPressed: _con.createCategory,
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

  Widget _categoriName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: MyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre de la categoria',
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

  Widget _descriptionCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
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

  void refresh() {
    setState(() {});
  }
}
