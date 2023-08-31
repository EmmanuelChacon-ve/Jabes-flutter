import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jabes/src/models/rol.dart';
import 'package:jabes/src/pages/roles/roles_controller.dart';
import 'package:jabes/src/utils/my_colors.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  late RolesController _con = RolesController();

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
        title: Text('Seleccione un rol'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
            children: _con.user != null
                ? _con.user!.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : []),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route!);
      },
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              // ignore: unnecessary_null_comparison
              image: rol.image != null
                  ? NetworkImage(rol.image!) as ImageProvider
                  : AssetImage('asset/img/no-image.png') as ImageProvider,
              fit: BoxFit.contain,
              placeholder: AssetImage('asset/img/no-image.png'),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            rol.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
