import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/Empleados/AlertaAgregarEmpleado.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/Empleados/AlertaEliminarEmpleado.dart';
import 'package:sistema_registro_pedidos_web/Widgets/Alertas/Empleados/AlertaModificarEmpleado.dart';

class HomeAdminEmpleados extends StatefulWidget {
  @override
  _HomeAdminEmpleadosState createState() => _HomeAdminEmpleadosState();
}

class _HomeAdminEmpleadosState extends State<HomeAdminEmpleados> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserLogged>(context, listen: false).actualizarEmpleados();
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
              'EMPLEADOS',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (_, _a) => SizedBox(
                    width: 50,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<UserLogged>(context).recepcionistas.length,
                  itemBuilder: (context, index) {
                    return empleadoItem(
                        Provider.of<UserLogged>(context).recepcionistas[index], index);
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
                  _showAgregarEmpleado();
                },
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Agregar nuevo empleado'),
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
          ],
        ),
      ),
    );
  }

  Future<void> _showAgregarEmpleado() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaAgregarEmpleado();
      },
    );
  }

  Future<void> _showEliminarEmpleado(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertaEliminarEmpleado(
          index: index,
        );
      },
    );
  }

  Future<void> _showModificarEmpleado(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        User empleado = Provider.of<UserLogged>(context, listen: false).recepcionistas[index];
        return AlertaModificarEmpleado(
          index: index,
          usuarioSeleccionado: empleado,
        );
      },
    );
  }

  Widget empleadoItem(User empleado, int index) {
    return InkWell(
      onTap: () {
        _showEliminarEmpleado(index);
      },
      onDoubleTap: () {
        _showModificarEmpleado(index);
      },
      child: Container(
        height: 300,
        width: 650,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(10.0, 10.0),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                child: Opacity(
                  opacity: 0.5,
                  child: Icon(
                    FontAwesome.user_circle,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Text(empleado.nombre + " " + empleado.apellido,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                )),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "NOMBRE",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.nombre,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "APELLIDO",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.apellido,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "CARNET DE IDENTIDAD",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.ci,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "CORREO ELECTRONICO",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.correo,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "DOMICILIO",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.domicilio,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "TELEFONO",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.telefono,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "CONTRASEÑA",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.password,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "PREGUNTA DE RECUPERACION",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.preguntaRecuperacion,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "RESPUESTA DE RECUPERACION",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          empleado.respuestaRecuperacion,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
