import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:sistema_registro_pedidos_web/Models/CentroComida.dart';
import 'package:sistema_registro_pedidos_web/Models/Food.dart';
import 'package:sistema_registro_pedidos_web/Models/Mesas.dart';
import 'package:sistema_registro_pedidos_web/Models/Pedido.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';

class UserLogged with ChangeNotifier {
  int _nroCentro = 0;
  bool _isLogged;
  String _typeUser = "none";
  User _userActually = User();

  CentroComida _centroComidaActual = CentroComida();
  User _admin = User();
  List<User> _recepcionistas = [];
  List<Food> _bebidas = [];
  List<Food> _menu = [];
  List<Mesas> _mesas = [];
  List<Pedido> _pedidos = [];

  Future actualizarCentroComidaActual() async {
    CentroComida centro = CentroComida();

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      centro = CentroComida(
        banner: jsonData['CC$_nroCentro']['banner'],
        descripcion: jsonData['CC$_nroCentro']['descripcion'],
        direccion: jsonData['CC$_nroCentro']['direccion'],
        horario: jsonData['CC$_nroCentro']['horario'],
        logo: jsonData['CC$_nroCentro']['logo'],
        nombre: jsonData['CC$_nroCentro']['nombre'],
        numero: jsonData['CC$_nroCentro']['numero'],
        tipo: jsonData['CC$_nroCentro']['tipo'],
      );
    }
    _centroComidaActual = centro;
    notifyListeners();
    print('Datos centro comida actual actualizado');
  }

  Future actualizarAdmin() async {
    User admin = User();

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      admin = User(
        nombre: jsonData['CC$_nroCentro']['Admin']['nombre'],
        apellido: jsonData['CC$_nroCentro']['Admin']['apellido'],
        cc: jsonData['CC$_nroCentro']['Admin']['cc'],
        ci: jsonData['CC$_nroCentro']['Admin']['ci'],
        correo: jsonData['CC$_nroCentro']['Admin']['correo'],
        domicilio: jsonData['CC$_nroCentro']['Admin']['domicilio'],
        password: jsonData['CC$_nroCentro']['Admin']['password'],
        preguntaRecuperacion: jsonData['CC$_nroCentro']['Admin']
            ['preguntaRecuperacion'],
        respuestaRecuperacion: jsonData['CC$_nroCentro']['Admin']
            ['respuestaRecuperacion'],
        telefono: jsonData['CC$_nroCentro']['Admin']['telefono'],
      );
    }
    _admin = admin;
    notifyListeners();
    print('Datos del admin del centro de comida actualizado');
  }

  Future actualizarEmpleados() async {
    _recepcionistas.clear();
    List<User> empleados = [];

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      empleados.clear();
      for (int j = 1;
          j <= jsonData['CC$_nroCentro']['Recepcionistas'].length;
          j++) {
        empleados.add(
          User(
            nombre: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']['nombre']
                .toString(),
            apellido: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']
                    ['apellido']
                .toString(),
            ci: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']['ci']
                .toString(),
            correo: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']['correo']
                .toString(),
            domicilio: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']
                    ['domicilio']
                .toString(),
            horario: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']
                    ['horario']
                .toString(),
            password: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']
                    ['password']
                .toString(),
            preguntaRecuperacion: jsonData['CC$_nroCentro']['Recepcionistas']
                    ['R$j']['preguntaRecuperacion']
                .toString(),
            respuestaRecuperacion: jsonData['CC$_nroCentro']['Recepcionistas']
                    ['R$j']['respuestaRecuperacion']
                .toString(),
            telefono: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']
                    ['telefono']
                .toString(),
            cc: jsonData['CC$_nroCentro']['Recepcionistas']['R$j']['cc'],
          ),
        );
      }
    }
    _recepcionistas = empleados;
    notifyListeners();
    print('Lista de empleados actualizados');
  }

  Future actualizarBebidas() async {
    _bebidas.clear();
    List<Food> bebidas = [];

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      for (int j = 1; j <= jsonData['CC$_nroCentro']['Bebidas'].length; j++) {
        bebidas.add(
          Food(
            descripcion: jsonData['CC$_nroCentro']['Bebidas']['B$j']
                ['descripcion'],
            img: jsonData['CC$_nroCentro']['Bebidas']['B$j']['img'],
            nombre: jsonData['CC$_nroCentro']['Bebidas']['B$j']['nombre'],
            precio: double.parse(
                jsonData['CC$_nroCentro']['Bebidas']['B$j']['precio']),
          ),
        );
      }
    }
    _bebidas = bebidas;
    notifyListeners();
    print('Lista de mesas actualizada');
  }

  Future actualizarMenu() async {
    _menu.clear();
    List<Food> menu = [];

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      for (int j = 1; j <= jsonData['CC$_nroCentro']['Menu'].length; j++) {
        menu.add(
          Food(
            descripcion: jsonData['CC$_nroCentro']['Menu']['C$j']['descripcion'].toString(),
            img: jsonData['CC$_nroCentro']['Menu']['C$j']['img'].toString(),
            nombre: jsonData['CC$_nroCentro']['Menu']['C$j']['nombre'].toString(),
            precio: double.parse(jsonData['CC$_nroCentro']['Menu']['C$j']['precio'].toString()),
          ),
        );
      }
    }
    _menu = menu;
    notifyListeners();
    print('Lista de menu actualizada');
  }

  Future actualizarMesas() async {
    _mesas.clear();
    List<Mesas> mesas = [];

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      for (int j = 1; j <= jsonData['CC$_nroCentro']['Mesas'].length; j++) {
        mesas.add(
          Mesas(
              nro: jsonData['CC$_nroCentro']['Mesas']['M$j']['nro'],
              disponible: jsonData['CC$_nroCentro']['Mesas']['M$j']['disponible'],
          )
        );
      }
    }
    _mesas = mesas;
    notifyListeners();
    print('Lista de mesas actualizada');
  }

  Future actualizarPedidos() async {
    List<Food> comida = [];

    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      _pedidos.clear();
      for (int i = 1; i <= jsonData['CC$_nroCentro']['Pedidos'].length; i++) {
        for (int j = 1;
            j <= jsonData['CC$_nroCentro']['Pedidos']['P$i']['Comidas'].length;
            j++) {
          comida.add(
            Food(
                nombre: jsonData['CC$i']['Pedidos']['P$i']['Comidas']['C$j']
                        ['nombre']
                    .toString(),
                descripcion: jsonData['CC$i']['Pedidos']['P$i']['Comidas']
                        ['C$j']['descripcion']
                    .toString(),
                img: jsonData['CC$i']['Pedidos']['P$i']['Comidas']['C$j']['img']
                    .toString(),
                precio: double.parse(jsonData['CC$i']['Pedidos']['P$i']
                    ['Comidas']['C$j']['precio']),
                cantidad: jsonData['CC$i']['Pedidos']['P$i']['Comidas']['C$j']
                    ['cantidad']),
          );
        }

        _pedidos.add(
          Pedido(
            ciRecepcionista: jsonData['CC$_nroCentro']['Pedidos']['P$i']['ciRecepcionista'],
            codigo: jsonData['CC$_nroCentro']['Pedidos']['P$i']['codigo'],
            comidas: comida,
            estado: jsonData['CC$_nroCentro']['Pedidos']['P$i']['estado'],
            fecha: jsonData['CC$_nroCentro']['Pedidos']['P$i']['fecha'],
            hora: jsonData['CC$_nroCentro']['Pedidos']['P$i']['hora'],
            nroMesa: jsonData['CC$_nroCentro']['Pedidos']['P$i']['nro'],
            tiempo: jsonData['CC$_nroCentro']['Pedidos']['P$i']['tiempo'],
            total: double.parse(jsonData['CC$_nroCentro']['Pedidos']['P$i']['total']),
            usuarioEmail: jsonData['CC$_nroCentro']['Pedidos']['P$i']['Usuario']['email'],
            usuarioUsername: jsonData['CC$_nroCentro']['Pedidos']['P$i']['Usuario']['username'],
          )
        );
        comida.clear();
      }
    }
    notifyListeners();
    print('Pedidos actualizados');
  }

  UserLogged(this._isLogged);

  int get nroCentro => _nroCentro;

  set nroCentro(int value){
    _nroCentro = value;
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
    _nroCentro = value.cc;
  }

  CentroComida get centroComidaActual => _centroComidaActual;

  set centroComidaActual(CentroComida value) {
    _centroComidaActual = value;
  }

  User get admin => _admin;

  set admin(User value) {
    _admin = value;
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
}
