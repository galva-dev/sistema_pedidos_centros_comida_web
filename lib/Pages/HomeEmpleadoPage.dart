import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Pages/Empleado/HomeEmpleadoMenu.dart';
import 'package:sistema_registro_pedidos_web/Pages/Empleado/HomeEmpleadoMesas.dart';
import 'package:sistema_registro_pedidos_web/Pages/Empleado/HomeEmpleadoPedidos.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';

class HomeEmpleadoPage extends StatefulWidget {
  const HomeEmpleadoPage({Key key}) : super(key: key);

  @override
  _HomeEmpleadoPageState createState() => _HomeEmpleadoPageState();
}

class _HomeEmpleadoPageState extends State<HomeEmpleadoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userLogged = Provider.of<UserLogged>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('EMPLEADO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              child: ElevatedButton(
                onPressed: () {
                  _userLogged.isLogged = false;
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('Cerrar sesion'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade700,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/appBar.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 10,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesomeIcons.clipboardList,
                  color: Colors.white,
                ),
                text: 'Pedidos',
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.listAlt,
                  color: Colors.white,
                ),
                text: 'Menu',
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.table,
                  color: Colors.white,
                ),
                text: 'Mesas',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeEmpleadoPedidos(),
            HomeEmpleadoMenu(),
            HomeEmpleadoMesas(),
          ],
        ),
      ),
    );
  }
}
