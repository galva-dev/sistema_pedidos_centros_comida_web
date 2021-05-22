import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Models/Food.dart';
import 'package:sistema_registro_pedidos_web/Models/Mesas.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/AlertaAgregarMesa.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/AlertaEliminarMesa.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/AlertaModificarMesa.dart';

class HomeAdminMesas extends StatefulWidget {
  HomeAdminMesas({Key key}) : super(key: key);

  @override
  _HomeAdminMesasState createState() => _HomeAdminMesasState();
}

class _HomeAdminMesasState extends State<HomeAdminMesas> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserLogged>(context, listen: false).actualizarMesas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 50, right: 50, top: 100),
      child: Center(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 300,
              height: 300,
            ),
            Text(
              'MESAS',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(100)),
                child: ListView.separated(
                  separatorBuilder: (_, _a) => SizedBox(
                    width: 50,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<UserLogged>(context).mesas.length,
                  itemBuilder: (context, index) {
                    return mesasItem(Provider.of<UserLogged>(context).mesas[index], index);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.red[100], spreadRadius: 10, blurRadius: 20)],
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showAgregarMesa();
                },
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Agregar mesa nueva'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.plusCircle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade700,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.red[100], spreadRadius: 10, blurRadius: 20)],
              ),
              child: ElevatedButton(
                onPressed: () {
                  //todo CODIGO PARA ACTUALIZAR LAS MESAS
                  Provider.of<UserLogged>(context, listen: false).actualizarMesas();
                },
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Actualizar las mesas'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.syncAlt,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow.shade800,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEliminarMesa(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaEliminarMesa(
          index: index,
        );
      },
    );
  }

  Future<void> _showAgregarMesa() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaAgregarMesa();
      },
    );
  }

  Future<void> _showModificarMesa(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaModificarMesa(
          index: index,
        );
      },
    );
  }

  Widget mesasItem(Mesas mesa, int index) {
    return InkWell(
      onTap: () {
        if (Provider.of<UserLogged>(context, listen: false).mesas.length - 1 == index) {
          if (Provider.of<UserLogged>(context, listen: false).mesas[index].disponible != 0) {
            _showEliminarMesa(index);
          }
        }
      },
      onDoubleTap: () {
        _showModificarMesa(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipOval(
                child: Container(
                  color: Colors.black,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/mesas.jpg',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 45,
                left: 45,
                child: Center(
                  child: Icon(
                    FontAwesome.table,
                    size: 60,
                    color: mesa.disponible == 0 ? Colors.red : Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 40,
                child: Text(
                  'Nro: ' + mesa.nro.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
