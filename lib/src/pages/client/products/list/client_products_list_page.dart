import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/models/category.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';
import 'package:jabes/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  final ClientProductsListController _con = ClientProductsListController();
  String? userImage;
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
      userImage = _con.user?.image?.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories.length,
      child: Scaffold(
          key: _con.key,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(170),
              child: AppBar(
                leading: _menuDrawer(),
                backgroundColor: MyColors.primaryColor2,
                flexibleSpace: Column(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  _textFieldSearch(),
                ]),
                bottom: TabBar(
                  indicatorColor: MyColors.primaryColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: List<Widget>.generate(_con.categories.length, (index) {
                    return Tab(
                      child: Text(_con.categories[index].name!),
                    );
                  }),
                ),
              )),
          drawer:
              _drawer(), //llamanndo al Widget _drawer() para poder ser mostrado
          body: TabBarView(
              children: _con.categories.map((Categorys categorys) {
            return FutureBuilder(
                future: _con.getProducts(categorys.id!, _con.productName),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.8),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return _cardProduct(snapshot.data![index]);
                        },
                      );
                    } else {
                      return NoDataWidget(
                        text: 'No hay Organizaciones',
                      );
                    }
                  } else {
                    return NoDataWidget(
                      text: 'No hay Organizaciones',
                    );
                  }
                }); // el FutureBuilder se utiliza para listar informacion de la Base de datos

            /* GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              children: List.generate(10, (index) {
                return _cardProduct();
              }),
            ); */
          }).toList())),
    );
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
      onTap: () {
        _con.gotoDetail(product);
      },
      child: Container(
        height: 250,
        child: Card(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Positioned(
                  top: -1.0,
                  right: -1.0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(20),
                        )),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(20),
                    child: FadeInImage(
                      image: product.image1 != null
                          ? NetworkImage(product.image1!)
                          : const AssetImage('asset/img/no-image.png')
                              as ImageProvider,
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('asset/img/no-image.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 33,
                    child: Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontFamily: 'NimbusSans'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: _con.onChangeText,
        decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
            hintStyle: TextStyle(fontSize: 17, color: Colors.grey[500]),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.grey)),
            contentPadding: const EdgeInsets.all(15)),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
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
            onTap: _con.gotoUpdatePage,
            title: const Text('Editar Perfil'),
            trailing: const Icon(Icons.edit_outlined),
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, 'client/payment/paymentMethods'),
            title: const Text('Donar/Voluntariado'),
            trailing: const Icon(Icons.volunteer_activism),
          ),
          const ListTile(
            title: Text('Registro de donaciones'),
            trailing: Icon(Icons.picture_as_pdf),
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

  void refresh() {
    setState(() {});
  }
}
