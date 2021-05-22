import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';

class HomeEmpleadoPage extends StatefulWidget {
  const HomeEmpleadoPage({Key key}) : super(key: key);

  @override
  _HomeEmpleadoPageState createState() => _HomeEmpleadoPageState();
}

class _HomeEmpleadoPageState extends State<HomeEmpleadoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            RaisedButton(
              padding: EdgeInsets.only(top: 5),
              child: Text('Prepare'),
              onPressed: () {
                FirebaseDatabaseWeb.instance
                    .reference()
                    .child("CentroComida")
                    .child("a")
                    .set("Click a button to change this to 'hello'");
                FirebaseDatabaseWeb.instance
                    .reference()
                    .child("CentroComida")
                    .child("b")
                    .set({
                  "1": "This will be",
                  "2": "hello world",
                  "3": "When you click the button"
                });
              },
            ),
            RaisedButton(
              padding: EdgeInsets.only(top: 5),
              child: Text('Set test/a = "hello"'),
              onPressed: () {
                FirebaseDatabaseWeb.instance
                    .reference()
                    .child("test")
                    .child("a")
                    .set("Hello");
              },
            ),
            RaisedButton(
              padding: EdgeInsets.only(top: 5),
              child: Text('Update test/b = {"1": "Hello", "2": "World!"}'),
              onPressed: () {
                FirebaseDatabaseWeb.instance
                    .reference()
                    .child("CentroComida")
                    .child("CC1")
                    .child('Recepcionistas')
                    .child('R1')
                    .update({"nombre": "Jose", "apellido": "Carrillo"});
              },
            ),
            RaisedButton(
              padding: EdgeInsets.only(top: 5),
              child: Text('Print the value of test in console'),
              onPressed: () async {
                DatabaseSnapshot snap = await FirebaseDatabaseWeb.instance
                    .reference()
                    .child("test")
                    .once();
                print(snap.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
