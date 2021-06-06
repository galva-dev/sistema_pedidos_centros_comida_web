import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sistema_registro_pedidos_web/Utils/FirebaseCrud.dart';

class AlertaModificarMesa extends StatelessWidget {
  Icon icon;
  String title;
  String descripcion;
  int index;
  int estado;

  AlertaModificarMesa(
      {this.descripcion = "description",
      this.icon = const Icon(
        FontAwesome.address_book,
        color: Colors.white,
        size: 15,
      ),
      this.title = "title",
      this.index,
      this.estado});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        clipBehavior: Clip.none, alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Alerta de modificacion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Seleccione el nuevo estado de la mesa",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FirebaseCrud.modificarMesa(context, index, 1);
                        },
                        child: Text(
                          'Disponible',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseCrud.modificarMesa(context, index, 0);
                        },
                        child: Text(
                          'Ocupada',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                      ),
                    ],
                  )
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
                FontAwesome.plus_circle,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
