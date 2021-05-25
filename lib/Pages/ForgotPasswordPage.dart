import 'package:flutter/material.dart';
import 'package:sistema_registro_pedidos_web/Models/User.dart';
import 'package:sistema_registro_pedidos_web/Widgets/ForgotPassword/Body.dart';
import 'package:sistema_registro_pedidos_web/Widgets/ForgotPassword/Footer.dart';
import 'package:sistema_registro_pedidos_web/Widgets/ForgotPassword/NavBar.dart';

class ForgotPasswordPage extends StatelessWidget {
  User usuario = User();
  ForgotPasswordPage({this.usuario});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        'assets/images/backgroundRotate.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NavBar(
                      nombreCompleto: usuario.nombre + " " + usuario.apellido,
                    ),
                    Body(
                      usuario: usuario,
                    ),
                    Footer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
