import 'dart:io';

import 'package:app_ropa/helpers/db_helper.dart';
import 'package:app_ropa/models/ropa_model.dart';
import 'package:flutter/foundation.dart';

class MiRopa extends ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  List<Ropa> _items = [];

  List<Ropa> get items {
    return [..._items]; //copia la lista para pegarla en otra
  }

  Ropa encontrarConId(int id) {
    return _items.firstWhere((ropa) => ropa.id == id);
  }

  Future<void> eliminarRopa(int id) async {
    final ropaFind = encontrarConId(id);
    _items.remove(ropaFind);
    notifyListeners();
    dbHelper.eliminar('mi_ropa', ropaFind.id);
  }

  Future<void> getRopa() async {
    final listaData = await dbHelper.obtenerDatos('mi_ropa');
    _items = listaData
        .map((item) => Ropa(
              id: item['id'],
              talla: item['talla'],
              marca: item['marca'],
              color: item['color'],
              imagen: File(item['imagen']),
              material: item['material'],
              precio: item['precio'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> agregarRopa(String marcaSel, String tallaSel, String colorSel,
      File imagenSel, String materialSel, int precioSel) async {
    final nuevaRopa = Ropa(
      marca: marcaSel,
      talla: tallaSel,
      color: colorSel,
      imagen: imagenSel,
      material: materialSel,
      precio: precioSel,
    );
    _items.add(nuevaRopa);
    notifyListeners();
    dbHelper.insertar('mi_ropa', {
      'marca': nuevaRopa.marca,
      'talla': nuevaRopa.talla,
      'color': nuevaRopa.color,
      'imagen': nuevaRopa.imagen.path,
      'material': nuevaRopa.material,
      'precio': nuevaRopa.precio,
    });
  }

  Future<void> editarRopa(
      int viejaId,
      String marcaNueva,
      String tallaNueva,
      String colorNueva,
      File imagenNueva,
      String materialNueva,
      int precioNueva) async {
    final editRopa = Ropa(
      id: viejaId,
      marca: marcaNueva,
      talla: tallaNueva,
      color: colorNueva,
      imagen: imagenNueva,
      material: materialNueva,
      precio: precioNueva,
    );
    _items.add(editRopa);
    _items.remove(encontrarConId(viejaId));
    notifyListeners();
    dbHelper.update(
        'mi_ropa',
        {
          'marca': marcaNueva,
          'talla': tallaNueva,
          'color': colorNueva,
          'imagen': imagenNueva.path,
          'material': materialNueva,
          'precio': precioNueva,
        },
        viejaId);
  }
}
