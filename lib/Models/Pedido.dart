import 'package:sistema_registro_pedidos_web/Models/Food.dart';

class Pedido {
  String codigo;
  String ciRecepcionista;
  String estado;
  String fecha;
  String hora;
  int nroMesa;
  int tiempo;
  double total;
  List<Food> comidas;
  String usuarioEmail;
  String usuarioUsername;

  Pedido({
    this.codigo,
    this.ciRecepcionista,
    this.estado,
    this.fecha,
    this.hora,
    this.nroMesa,
    this.tiempo,
    this.total,
    this.comidas,
    this.usuarioEmail,
    this.usuarioUsername,
  });

  
}
