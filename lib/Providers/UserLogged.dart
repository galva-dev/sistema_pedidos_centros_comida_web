import 'dart:convert';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:sistema_registro_pedidos_web/Models/CentroComida.dart';
import 'package:sistema_registro_pedidos_web/Models/Food.dart';
import 'package:sistema_registro_pedidos_web/Models/Mesas.dart';
import 'package:sistema_registro_pedidos_web/Models/Pedido.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';

class UserLogged with ChangeNotifier {
  String _keyCentro = "";
  bool _isLogged;
  String _typeUser = "none";

  User _userActually = User();

  List<User> _recepcionistas = [];
  List<Food> _bebidas = [];
  List<Food> _menu = [];
  List<Mesas> _mesas = [];
  List<Pedido> _pedidos = [];
  List<User> loginempleados = [];
  List<User> loginadmin = [];

  UserLogged(this._isLogged);

  get keyCentro => _keyCentro;

  set keyCentro(String value) {
    _keyCentro = value;
  }

  bool get isLogged => _isLogged;

  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  String get typeUser => _typeUser;

  set typeUser(String value) {
    _typeUser = value;
  }

  User get userActually => _userActually;

  set userActually(User value) {
    _userActually = value;
    _keyCentro = value.cc;
  }

  List<User> get recepcionistas => _recepcionistas;

  set recepcionistas(List<User> value) {
    _recepcionistas = value;
    notifyListeners();
  }

  List<Food> get bebidas => _bebidas;

  set bebidas(List<Food> value) {
    _bebidas = value;
    notifyListeners();
  }

  List<Food> get menu => _menu;

  set menu(List<Food> value) {
    _menu = value;
    notifyListeners();
  }

  List<Mesas> get mesas => _mesas;

  set mesas(List<Mesas> value) {
    _mesas = value;
    notifyListeners();
  }

  List<Pedido> get pedidos => _pedidos;

  set Pedidos(List<Pedido> value) {
    _pedidos = value;
    notifyListeners();
  }

  List<User> get getLoginempleados => this.loginempleados;

  set setLoginempleados(List<User> loginempleados) => this.loginempleados = loginempleados;

  List<User> get getLoginadmin => this.loginadmin;

  set setLoginadmin(loginadmin) => this.loginadmin = loginadmin;

  Future getEmpleados() async {
    loginempleados.clear();
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db.once().then((value) {
      Map centrosComidaJson = value.value;
      centrosComidaJson.forEach((keyCC, valueCC) async {
        await db.child(keyCC.toString()).child('Recepcionistas').once().then((value) {
          Map recepcionistasJson = value.value;
          recepcionistasJson.forEach((keyR, valueR) {
            loginempleados.add(User(
                key: keyR.toString(),
                apellido: valueR['apellido'],
                cc: valueR['cc'],
                ci: valueR['ci'],
                correo: valueR['correo'],
                domicilio: valueR['domicilio'],
                horario: valueR['horario'],
                nombre: valueR['nombre'],
                password: valueR['password'],
                preguntaRecuperacion: valueR['preguntaRecuperacion'],
                respuestaRecuperacion: valueR['respuestaRecuperacion'],
                telefono: valueR['telefono']));
          });
        }).then((value) => print('Empleados total: ${loginempleados.length}'));
      });
    });
  }

  Future getAdmin() async {
    loginadmin.clear();
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db.once().then((value) {
      Map centrosComidaJson = value.value;
      centrosComidaJson.forEach((keyCC, valueCC) async {
        await db.child(keyCC.toString()).child('Admin').once().then((value) {
          Map adminJson = value.value;
          loginadmin.add(User(
              key: 'noKey',
              apellido: adminJson['apellido'].toString(),
              cc: adminJson['cc'].toString(),
              ci: adminJson['ci'].toString(),
              correo: adminJson['correo'].toString(),
              domicilio: adminJson['domicilio'].toString(),
              nombre: adminJson['nombre'].toString(),
              password: adminJson['password'].toString(),
              preguntaRecuperacion: adminJson['preguntaRecuperacion'].toString(),
              respuestaRecuperacion: adminJson['respuestaRecuperacion'].toString(),
              telefono: adminJson['telefono'].toString()));
        }).then((value) => print('Admin total: ${loginadmin.length}'));
      });
    });
  }

  Future actualizarMesas() async {
    _mesas.clear();
    List<Mesas> mesas = [];

    final uri =
        Uri.parse("https://sistemaregistropedidos-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body =
          utf8.decode(response.bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      for (int j = 1; j <= jsonData[_keyCentro]['Mesas'].length; j++) {
        mesas.add(Mesas(
          nro: jsonData[_keyCentro]['Mesas']['M$j']['nro'],
          disponible: jsonData[_keyCentro]['Mesas']['M$j']['disponible'],
        ));
      }
    }
    _mesas = mesas;
    notifyListeners();
    print('Lista de mesas actualizada');
  }

  Future actualizarEmpleados() async {
    _recepcionistas.clear();

    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db.child(_keyCentro).child('Recepcionistas').once().then((value) {
      Map recepcionistasJson = value.value;
      recepcionistasJson.forEach((key, value) {
        _recepcionistas.add(User(
          key: key.toString(),
          apellido: value['apellido'],
          cc: value['cc'],
          ci: value['ci'],
          correo: value['correo'],
          domicilio: value['domicilio'],
          horario: value['horario'],
          nombre: value['nombre'],
          password: value['password'],
          preguntaRecuperacion: value['preguntaRecuperacion'],
          respuestaRecuperacion: value['respuestaRecuperacion'],
          telefono: value['telefono'],
        ));
      });
    });
    notifyListeners();
    print('Lista de empleados actualizada');
  }
}
