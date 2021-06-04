import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';

class FirebaseCrud {
  static void eliminarMesa(int index, BuildContext context) async {
    int nro = Provider.of<UserLogged>(context, listen: false).nroCentro;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child('CC$nro')
        .child('Mesas')
        .child('M${index + 1}')
        .remove()
        .then((value) => print('Mesa eliminada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void agregarMesa(BuildContext context) async {
    int nro = Provider.of<UserLogged>(context, listen: false).nroCentro;
    int index = Provider.of<UserLogged>(context, listen: false).mesas.length + 1;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child('CC$nro')
        .child('Mesas')
        .child('M$index')
        .set({'disponible': 1, 'nro': index}).then((value) => print('Mesa agregada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void modificarMesa(BuildContext context, int nroMesa, int disponible) async {
    int nro = Provider.of<UserLogged>(context, listen: false).nroCentro;
    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    await db
        .child('CC$nro')
        .child('Mesas')
        .child('M${nroMesa + 1}')
        .update({'disponible': disponible}).then((value) => print('Mesa modificada'));
    await Provider.of<UserLogged>(context, listen: false).actualizarMesas().then((value) {
      Navigator.of(context).pop();
    });
  }

  static void modificarPassword(BuildContext context, String nuevaContra, int nro, int rNro) async {
    String tipoUsuario = Provider.of<UserLogged>(context, listen: false).typeUser;

    final db = FirebaseDatabaseWeb.instance.reference().child('CentroComida');
    if (tipoUsuario == "Admin") {
      await db
          .child('CC$nro')
          .child('Admin')
          .update({'password': nuevaContra}).then((value) => print('Password modificado'));
      await Provider.of<UserLogged>(context, listen: false).getAdmin().then((value) {
        Navigator.of(context).pop();
      });
    } else {
      await db
          .child('CC$nro')
          .child('Recepcionistas')
          .child('R$rNro')
          .update({'password': nuevaContra}).then((value) => print('Password modificado'));
      await Provider.of<UserLogged>(context, listen: false).getEmpleados().then((value) {
        Navigator.of(context).pop();
      });
    }
  }
}
