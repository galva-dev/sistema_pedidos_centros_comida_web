import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/AdvancedAlertDialog.dart';

class DetailSide extends StatefulWidget {
  final Animation<double> _animation;
  List<User> empleado = [];
  List<User> admin = [];

  DetailSide(
      {Key key,
      @required Animation<double> animation,
      this.empleado,
      this.admin})
      : _animation = animation,
        super(key: key);

  @override
  _DetailSideState createState() => _DetailSideState();
}

class _DetailSideState extends State<DetailSide> {
  bool isVisible = true;
  String password = "none";
  String ci = "none";

  @override
  void initState() {
    super.initState();
  }

  void _toggleVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  Future<void> _showMyDialog(
      String title, String descripcion, Icon icon) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AdvancedAlertDialog(
          descripcion: descripcion,
          icon: icon,
          title: title,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userLogged = Provider.of<UserLogged>(context, listen: false);

    return Align(
      alignment: Alignment(-widget._animation.value, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.63,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            Text(
              widget._animation.value < 0.0 ? 'Administrador' : 'Empleado',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Container(
                width: 170.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 53.0,
              width: 350.0,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    ci = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF4F8F7),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Feather.user,
                      size: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'CI',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 53.0,
              width: 350.0,
              child: TextField(
                onChanged: (value) => setState(() {
                  password = value;
                }),
                obscureText: isVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF4F8F7),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Feather.lock,
                      size: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'Contraseña',
                  suffixIcon: IconButton(
                      icon: isVisible
                          ? Icon(FontAwesome.eye_slash)
                          : Icon(
                              FontAwesome.eye,
                              color: Colors.blue,
                            ),
                      onPressed: _toggleVisible),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            widget._animation.value < 0.0
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(
                    height: 20.0,
                  ),
            widget._animation.value < 0.0
                ? InkWell(
                    onTap: () {},
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  )
                : InkWell(
                    onTap: () {},
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
            SizedBox(
              height: 30.0,
            ),
            widget._animation.value < 0.0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red[100],
                            spreadRadius: 10,
                            blurRadius: 20)
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        bool exist = false;
                        this.widget.admin.forEach((element) {
                          if (element.ci == ci) {
                            if (element.password == password) {
                              _userLogged.userActually = User(
                                  apellido: element.apellido,
                                  cc: element.cc,
                                  ci: element.ci,
                                  correo: element.correo,
                                  domicilio: element.domicilio,
                                  horario: element.horario,
                                  nombre: element.nombre,
                                  password: element.password,
                                  preguntaRecuperacion:
                                      element.preguntaRecuperacion,
                                  respuestaRecuperacion:
                                      element.respuestaRecuperacion,
                                  telefono: element.telefono,);
                              _userLogged.typeUser = 'Admin';
                              _userLogged.isLogged = true;
                              exist = true;
                            }
                          }
                        });
                        if (exist == false) {
                          //Alerta de no existe usuario
                          _showMyDialog(
                              "Usuario incorrecto",
                              "El administrador ingresado no existe",
                              Icon(FontAwesome.frown_o));
                          print('El administrador no existe');
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        child: Center(child: Text('Iniciar Sesion')),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red[100],
                            spreadRadius: 10,
                            blurRadius: 20)
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        bool exist = false;
                        this.widget.empleado.forEach((element) {
                          if (element.ci == ci) {
                            if (element.password == password) {
                              _userLogged.userActually = User(
                                  apellido: element.apellido,
                                  cc: element.cc,
                                  ci: element.ci,
                                  correo: element.correo,
                                  domicilio: element.domicilio,
                                  horario: element.horario,
                                  nombre: element.nombre,
                                  password: element.password,
                                  preguntaRecuperacion:
                                      element.preguntaRecuperacion,
                                  respuestaRecuperacion:
                                      element.respuestaRecuperacion,
                                  telefono: element.telefono);
                              _userLogged.typeUser = 'Empleado';
                              _userLogged.isLogged = true;
                              exist = true;
                            }
                          }
                        });
                        if (exist == false) {
                          //Alerta de no existe usuario
                          _showMyDialog(
                              "Usuario incorrecto",
                              "El empleado ingresado no existe",
                              Icon(FontAwesome.frown_o));
                          print('El empleado no existe');
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        child: Center(child: Text('Iniciar Sesion')),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
