import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';

class FirebaseCrud {
  static void eliminarMesa(int index, BuildContext context) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child(keyCentro)
        .child('Mesas')
        .child('M${index + 1}')
        .remove()
        .then((value) => print('Mesa eliminada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void agregarMesa(BuildContext context) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    int index = Provider.of<UserLogged>(context, listen: false).mesas.length + 1;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child(keyCentro)
        .child('Mesas')
        .child('M$index')
        .set({'disponible': 1, 'nro': index}).then((value) => print('Mesa agregada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void modificarMesa(BuildContext context, int nroMesa, int disponible) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child(keyCentro)
        .child('Mesas')
        .child('M${nroMesa + 1}')
        .update({'disponible': disponible}).then((value) => print('Mesa modificada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void modificarPassword(BuildContext context, String nuevaContra, String keyRecepcionista,
      String keyCentroComida) async {
    String tipoUsuario = Provider.of<UserLogged>(context, listen: false).typeUser;

    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    if (tipoUsuario == "Admin") {
      await db
          .child(keyCentroComida)
          .child('Admin')
          .update({'password': nuevaContra}).then((value) => print('Password modificado'));
      await Provider.of<UserLogged>(context, listen: false).getAdmin().then((value) {
        Navigator.of(context).pop();
      });
    } else {
      await db
          .child(keyCentroComida)
          .child('Recepcionistas')
          .child(keyRecepcionista)
          .update({'password': nuevaContra}).then((value) => print('Password modificado'));
      await Provider.of<UserLogged>(context, listen: false).getEmpleados().then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  static void agregarEmpleado(BuildContext context, User nuevoEmpleado) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db.child(keyCentro).child('Recepcionistas').push().set({
      'apellido': nuevoEmpleado.apellido,
      'cc': keyCentro,
      'ci': nuevoEmpleado.ci,
      'correo': nuevoEmpleado.correo,
      'domicilio': nuevoEmpleado.domicilio,
      'horario': nuevoEmpleado.horario,
      'nombre': nuevoEmpleado.nombre,
      'password': nuevoEmpleado.password,
      'preguntaRecuperacion': nuevoEmpleado.preguntaRecuperacion,
      'respuestaRecuperacion': nuevoEmpleado.respuestaRecuperacion,
      'telefono': nuevoEmpleado.telefono,
    }).then((value) => print('Empleado agregado'));
    await Provider.of<UserLogged>(context, listen: false).actualizarEmpleados().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void eliminarEmpleado(int index, BuildContext context) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    String keyEmpleado = Provider.of<UserLogged>(context, listen: false).recepcionistas[index].key;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child(keyCentro)
        .child('Recepcionistas')
        .child(keyEmpleado)
        .remove()
        .then((value) => print('Empleado eliminado'));
    await Provider.of<UserLogged>(context, listen: false).actualizarEmpleados().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void modificarEmpleado(BuildContext context, int index, User nuevosDatos) async {
    String keyCentro = Provider.of<UserLogged>(context, listen: false).keyCentro;
    String keyEmpleado = Provider.of<UserLogged>(context, listen: false).recepcionistas[index].key;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db.child(keyCentro).child('Recepcionistas').child(keyEmpleado).update({
      'apellido': nuevosDatos.apellido,
      'correo': nuevosDatos.correo,
      'domicilio': nuevosDatos.domicilio,
      'horario': nuevosDatos.horario,
      'nombre': nuevosDatos.nombre,
      'password': nuevosDatos.password,
      'preguntaRecuperacion': nuevosDatos.preguntaRecuperacion,
      'respuestaRecuperacion': nuevosDatos.respuestaRecuperacion,
      'telefono': nuevosDatos.telefono,
    }).then((value) => print('Empleado modificado'));
    await Provider.of<UserLogged>(context, listen: false).actualizarEmpleados().then((value) {
      Navigator.of(context).pop();
    });
  }
}
