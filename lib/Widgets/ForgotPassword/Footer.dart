import 'package:flutter/material.dart';
import 'package:sistema_registro_pedidos_web/Responsive/Responsive.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesktopFooter();
  }
}

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Universidad del Valle - La Paz',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
