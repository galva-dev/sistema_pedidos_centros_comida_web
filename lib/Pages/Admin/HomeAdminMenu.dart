import 'package:flutter/material.dart';

class HomeAdminMenu extends StatefulWidget {
  HomeAdminMenu({Key key}) : super(key: key);

  @override
  _HomeAdminMenuState createState() => _HomeAdminMenuState();
}

class _HomeAdminMenuState extends State<HomeAdminMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Menu'),
      ),
    );
  }
}