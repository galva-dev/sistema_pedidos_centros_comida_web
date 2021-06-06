import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Responsive/Responsive.dart';
import 'package:sistema_registro_pedidos_web/Utils/FirebaseCrud.dart';

class Body extends StatefulWidget {
  User usuario = User();
  Body({Key key, this.usuario}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String respuesta = "";
  String nuevaContrasenia = "";
  bool respuestaCorrecta = false;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                child: Column(
                  mainAxisAlignment:
                      !isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
                  crossAxisAlignment:
                      !isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    if (isMobile(context))
                      Expanded(
                        child: Image.asset(
                          '/assets/images/logo.png',
                          height: size.height * 0.4,
                        ),
                      ),
                    Text(
                      respuestaCorrecta
                          ? "INGRESE LA NUEVA CONTRASEÑA"
                          : "PREGUNTA DE RECUPERACION",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      respuestaCorrecta ? "" : widget.usuario.preguntaRecuperacion,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Container(
                      height: 53.0,
                      width: 350.0,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            if (respuestaCorrecta)
                              nuevaContrasenia = value;
                            else
                              respuesta = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: myController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF4F8F7),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.question_answer,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                          ),
                          hintText: respuestaCorrecta ? 'Nueva contraseña' : 'Respuesta',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        respuestaCorrecta
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: TextButton(
                                  onPressed: () {
                                    //todo CODIGO DE LA ACTUALIZACION DE LA CONTRA
                                    FirebaseCrud.modificarPassword(context, nuevaContrasenia, this.widget.usuario.key, this.widget.usuario.cc);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.yellow.shade700),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                    ),
                                    animationDuration: Duration(milliseconds: 800),
                                  ),
                                  child: Text(
                                    'ESTABLECER',
                                    style:
                                        TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: TextButton(
                                  onPressed: () {
                                    if (respuesta.isNotEmpty) {
                                      if (respuesta == this.widget.usuario.respuestaRecuperacion) {
                                        print('respuesta correcta');
                                        setState(() {
                                          respuestaCorrecta = true;
                                          myController.clear();
                                        });
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.green),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                    ),
                                    animationDuration: Duration(milliseconds: 800),
                                  ),
                                  child: Text(
                                    'CONTESTAR',
                                    style:
                                        TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (isDesktop(context) || isTablet(context))
              Expanded(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: size.height * 0.7,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
