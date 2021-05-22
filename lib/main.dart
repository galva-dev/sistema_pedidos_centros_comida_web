import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_registro_pedidos_web/Pages/HomePage.dart';
import 'package:sistema_registro_pedidos_web/Pages/SignInPage.dart';
import 'package:sistema_registro_pedidos_web/Providers/UserLogged.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserLogged>(
          create: (_) => UserLogged(false),
        )
      ],
      child: MyWeb(),
    ),
  );
}

class MyWeb extends StatefulWidget {
  @override
  _MyWebState createState() => _MyWebState();
}

class _MyWebState extends State<MyWeb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userLogged = Provider.of<UserLogged>(context);

    return MaterialApp(
      title: "¡A COMER!",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.black),
      home: _userLogged.isLogged ? HomePage() : SignInPage(),
    );
    // home: HomeAdminPage(),
  }
}
