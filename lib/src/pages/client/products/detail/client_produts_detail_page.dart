import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:jabes/src/models/product.dart';
import 'package:jabes/src/pages/client/payment/payment_methods.dart';
import 'package:jabes/src/pages/client/products/detail/client_products_detail_controller.dart';

import 'package:jabes/src/utils/my_colors.dart';

// ignore: must_be_immutable
class CLientProductsDetailPage extends StatefulWidget {
  Product? product;
  CLientProductsDetailPage({super.key, this.product});

  @override
  State<CLientProductsDetailPage> createState() =>
      _CLientProductsDetailPageState();
}

class _CLientProductsDetailPageState extends State<CLientProductsDetailPage> {
  ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.product != null) {
        _con.init(context, refresh, widget.product!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _imageSlideshow(),
            _textName(),
            _textDescription(),
            _buttonShoppingBag()
          ],
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.product?.description ?? '',
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Text(
        _con.product?.name ?? '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buttonShoppingBag() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: () {
          Product? productoAgregado = _con.addToDonation();
          if (productoAgregado != null) {
            setState(() {
              _con.product = productoAgregado;
            });
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MetodosPago(
                        categoria: productoAgregado!,
                      )));
        },
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Donar a la Organizacion',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 14, top: 10),
                height: 30,
                child: Image.asset('asset/img/4.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageSlideshow() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ImageSlideshow(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              initialPage: 0,
              indicatorColor: MyColors.primaryColor,
              indicatorBackgroundColor: Colors.grey,
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              autoPlayInterval: 30000,
              children: [
                FadeInImage(
                  image: _con.product?.image1 != null
                      ? NetworkImage(_con.product!.image1!)
                      : const AssetImage('asset/img/no-image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: const AssetImage('asset/img/no-image.png'),
                ),
                FadeInImage(
                  image: _con.product?.image2 != null
                      ? NetworkImage(_con.product!.image2!)
                      : const AssetImage('asset/img/no-image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: const AssetImage('asset/img/no-image.png'),
                ),
                FadeInImage(
                  image: _con.product?.image3 != null
                      ? NetworkImage(_con.product!.image3!)
                      : const AssetImage('asset/img/no-image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: const AssetImage('asset/img/no-image.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
