import 'dart:io';

import 'package:flutter/foundation.dart';

class Ropa {
  final int id;
  final String talla;
  final String marca;
  final String color;
  final String material;
  final int precio;
  final File imagen;

  Ropa({
    this.id, //no es necesaria porque es autoincrementable
    @required this.talla,
    @required this.marca,
    @required this.color,
    @required this.material,
    @required this.precio,
    @required this.imagen,
  });
}
