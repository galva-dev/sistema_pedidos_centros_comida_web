import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Utils/FirebaseCrud.dart';

class AlertaAgregarEmpleado extends StatefulWidget {
  Icon icon;
  String title;
  String descripcion;
  int index;

  AlertaAgregarEmpleado(
      {this.descripcion = "description",
      this.icon = const Icon(
        FontAwesome.address_book,
        color: Colors.white,
        size: 15,
      ),
      this.title = "title",
      this.index});

  @override
  _AlertaAgregarEmpleadoState createState() => _AlertaAgregarEmpleadoState();
}

class _AlertaAgregarEmpleadoState extends State<AlertaAgregarEmpleado> {

  final _formKey = GlobalKey<FormState>();

  String nombreText = "";

  String apellidoText = "";

  String ciText = "";

  String telefonoText = "";

  String correoText = "";

  String horarioText = "";

  String contraseniaText = "";

  String domicilioText = "";

  String preguntaRecText = "";

  String respuestaRecText = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 790,
            width: 850,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ingrese los datos del nuevo empleado',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 600,
                    width: 800,
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 500,
                                width: 320,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textFormNombre(),
                                    textFormCI(),
                                    textFormDomicilio(),
                                    textFormCorreo(),
                                    textFormRespRec(),
                                  ],
                                ),
                              ),
                              Container(
                                height: 500,
                                width: 320,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textFormApellido(),
                                    textFormTelefono(),
                                    textFormContra(),
                                    textFormPregRec(),
                                    textFormHorario(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState != null) {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      FirebaseCrud.agregarEmpleado(context, User(
                                        apellido: apellidoText,
                                        ci: ciText,
                                        correo: correoText,
                                        domicilio: domicilioText,
                                        horario: horarioText,
                                        nombre: nombreText,
                                        password: contraseniaText,
                                        preguntaRecuperacion: preguntaRecText,
                                        respuestaRecuperacion: respuestaRecText,
                                        telefono: telefonoText
                                      ));
                                    }
                                  }
                                },
                                child: Text(
                                  'Aceptar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 60,
              child: Icon(
                FontAwesome.user_plus,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFormHorario() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          horarioText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Horario',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el horario',
        icon: Icon(
          FontAwesome.calendar,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormPregRec() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          preguntaRecText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Pregunta de recuperacion',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese la pregunta de recuperacion',
        icon: Icon(
          FontAwesome.question,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormContra() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          contraseniaText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Contraseña',
        icon: Icon(
          FontAwesome.lock,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormTelefono() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          telefonoText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Telefono',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el telefono',
        icon: Icon(
          FontAwesome.phone,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormApellido() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          apellidoText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Apellido',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el apellido',
        icon: Icon(
          FontAwesome.user,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormRespRec() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          respuestaRecText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Respuesta de recuperacion',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese la respuesta de recuperacion',
        icon: Icon(
          FontAwesome.comment,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormCorreo() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          correoText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Correo',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el correo',
        icon: Icon(
          FontAwesome.envelope,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormDomicilio() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          domicilioText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Domicilio',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el domicilio',
        icon: Icon(
          FontAwesome.home,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormCI() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          ciText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Carnet de identidad',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el CI',
        icon: Icon(
          FontAwesome.user,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }

  TextFormField textFormNombre() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          nombreText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2),
        ),
        hintText: 'Ingrese el nombre',
        icon: Icon(
          FontAwesome.user,
          color: Colors.blue,
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.length == 0) {
          return 'No puede dejar campos vacios!';
        } else
          return null;
      },
    );
  }
}
