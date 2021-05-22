import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Widgets/DetailSide.dart';
import 'package:sistema_registro_pedidos_web/Widgets/SwitcherSide.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double width = 200.0;
  double containerWidth = 0.0;
  double alignText = 0.0;
  double welcomeText = 0.0;
  double opacity = 1.0;
  double oldRange;
  double newRange;
  double newValue;

  List<User> empleados = [];
  List<User> admin = [];

  Future _getEmpleados() async {
    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      empleados.clear();
      for (int i = 1; i <= jsonData.length; i++) {
        for (int j = 1; j <= jsonData['CC$i']['Recepcionistas'].length; j++) {
          empleados.add(
            User(
              nombre: jsonData['CC$i']['Recepcionistas']['R$j']['nombre']
                  .toString(),
              apellido: jsonData['CC$i']['Recepcionistas']['R$j']['apellido']
                  .toString(),
              ci: jsonData['CC$i']['Recepcionistas']['R$j']['ci'].toString(),
              correo: jsonData['CC$i']['Recepcionistas']['R$j']['correo']
                  .toString(),
              domicilio: jsonData['CC$i']['Recepcionistas']['R$j']['domicilio']
                  .toString(),
              horario: jsonData['CC$i']['Recepcionistas']['R$j']['horario']
                  .toString(),
              password: jsonData['CC$i']['Recepcionistas']['R$j']['password']
                  .toString(),
              preguntaRecuperacion: jsonData['CC$i']['Recepcionistas']['R$j']
                      ['preguntaRecuperacion']
                  .toString(),
              respuestaRecuperacion: jsonData['CC$i']['Recepcionistas']['R$j']
                      ['respuestaRecuperacion']
                  .toString(),
              telefono: jsonData['CC$i']['Recepcionistas']['R$j']['telefono']
                  .toString(),
              cc: jsonData['CC$i']['Recepcionistas']['R$j']['cc'],
            ),
          );
        }
      }
    }
    print('Empleados total: ${empleados.length}');
  }

  Future _getAdmin() async {
    final uri = Uri.parse(
        "https://ejemplodb-5afcd-default-rtdb.firebaseio.com/CentroComida.json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String body = utf8.decode(response
          .bodyBytes); // para mostrar caracteres especiales sin simbolos raros
      Map jsonData = json.decode(body);

      admin.clear();
      for (int i = 1; i <= jsonData.length; i++) {
        admin.add(
          User(
            nombre: jsonData['CC$i']['Admin']['nombre'].toString(),
            apellido: jsonData['CC$i']['Admin']['apellido'].toString(),
            ci: jsonData['CC$i']['Admin']['ci'].toString(),
            correo: jsonData['CC$i']['Admin']['correo'].toString(),
            domicilio: jsonData['CC$i']['Admin']['domicilio'].toString(),
            horario: jsonData['CC$i']['Admin']['horario'].toString(),
            password: jsonData['CC$i']['Admin']['password'].toString(),
            preguntaRecuperacion:
                jsonData['CC$i']['Admin']['preguntaRecuperacion'].toString(),
            respuestaRecuperacion:
                jsonData['CC$i']['Admin']['respuestaRecuperacion'].toString(),
            telefono: jsonData['CC$i']['Admin']['telefono'].toString(),
            cc: jsonData['CC$i']['Admin']['cc'],
          ),
        );
      }
      print('Admin total: ${admin.length}');
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
      reverseCurve: Curves.easeInOutSine,
    ));

    _controller.addListener(() {
      setState(() {
        if (_animation.value >= -1.0 && _animation.value <= 0.0) {
          oldRange = (0.0 - (-1.0));
          newRange = (300.0 - 200.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 200.0;
          width = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (150.0 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          containerWidth = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (-1.8 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          alignText = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (-7.0 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          welcomeText = newValue;
        } else {
          oldRange = (1.0 - (0.0));
          newRange = (200.0 - 300.0);
          newValue =
              (((_animation.value - (0.0)) * newRange) / oldRange) + 300.0;
          width = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 150.0);
          newValue =
              (((_animation.value - (0.0)) * newRange) / oldRange) + 150.0;
          containerWidth = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 1.8);
          newValue = (((_animation.value - (0.0)) * newRange) / oldRange) + 1.8;
          alignText = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 7.0);
          newValue = (((_animation.value - (0.0)) * newRange) / oldRange) + 7.0;
          welcomeText = newValue;
        }
      });
    });

    _getEmpleados();
    _getAdmin();
  }

  double align = -1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login/background.jpg'),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
            ),
            child: Stack(
              children: [
                DetailSide(
                  animation: _animation,
                  admin: admin,
                  empleado: empleados,
                ),
                SwitcherSide(
                    animation: _animation,
                    containerWidth: containerWidth,
                    welcomeText: welcomeText,
                    controller: _controller,
                    width: width,
                    alignText: alignText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
