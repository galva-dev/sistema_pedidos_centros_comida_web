import 'dart:ui';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Pages/Admin/HomeAdminEmpleados.dart';
import 'package:sistema_registro_pedidos_web/Pages/Admin/HomeAdminMenu.dart';
import 'package:sistema_registro_pedidos_web/Pages/Admin/HomeAdminMesas.dart';
import 'package:sistema_registro_pedidos_web/Pages/Admin/HomeAdminMisDatos.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/AlertaCerrarSesion.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key key}) : super(key: key);

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int currentIndex = 4;

  List currentPage = [
    HomeAdminMenu(),
    HomeAdminMesas(),
    HomeAdminEmpleados(),
    HomeAdminMisDatos(),
    Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 500,
              height: 500,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'BIENVENIDO',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            Text(
              'Utilice la barra de navegación en la parte inferior de su pantalla',
              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 40),
            ),
          ],
        ),
      ),
    ),
  ];

  Future<void> _showCerrarSesion() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaCerrarSesion();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserLogged>(context, listen: false).actualizarMesas();
    Provider.of<UserLogged>(context, listen: false).actualizarEmpleados();
    Provider.of<UserLogged>(context, listen: false).actualizarCentroComidaActual();
    Provider.of<UserLogged>(context, listen: false).actualizarMenu();
  }

  @override
  Widget build(BuildContext context) {
    final _userLogged = Provider.of<UserLogged>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(top: 15, left: 50),
          child: Row(
            children: [
              Text(
                _userLogged.userActually.nombre + " " + _userLogged.userActually.apellido,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 50, top: 20),
            child: ElevatedButton(
              onPressed: () {
                _showCerrarSesion();
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/backgroundRotate.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.0),
                        ),
                      )),
                ),
              ),
            ),
            currentPage[currentIndex]
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 80,
        iconSize: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: Colors.transparent,
        curve: Curves.fastOutSlowIn,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.utensils),
              title: Text('   Menu'),
              activeColor: Colors.orange,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.table),
              title: Text('   Mesas'),
              activeColor: Colors.purple,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.users),
              title: Text(
                '    Empleados',
                style: TextStyle(fontSize: 10),
              ),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.userCircle),
              title: Text('  Mis datos'),
              activeColor: Colors.red,
              inactiveColor: Colors.grey),
        ],
      ),
      extendBody: true,
    );
  }
}
