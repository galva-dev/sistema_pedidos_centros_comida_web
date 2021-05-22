import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Pages/HomeAdminPage.dart';
import 'package:sistema_registro_pedidos_web/Pages/HomeEmpleadoPage.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _userLogged = Provider.of<UserLogged>(context, listen: false);

    return _userLogged.typeUser=='Admin' ? HomeAdminPage() : HomeEmpleadoPage();
  }
}
