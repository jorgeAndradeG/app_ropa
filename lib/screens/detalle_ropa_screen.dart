import 'package:app_ropa/providers/mi_ropa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editar_ropa_screen.dart';

class DetalleRopaScreen extends StatelessWidget {
  static const routeName = 'detalle_ropa';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final ropaSel =
        Provider.of<MiRopa>(context, listen: false).encontrarConId(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(ropaSel.marca),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditarRopaScreen.routeName,
                      arguments: ropaSel.id);
                })
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(ropaSel.imagen,
                  fit: BoxFit.cover, width: double.infinity),
            ),
            SizedBox(height: 30),
            Text(
              'Talla: ' + ropaSel.talla,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              'Material: ' + ropaSel.material,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              'Precio: ' + ropaSel.precio.toString() + " CLP",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 15),
            Text(ropaSel.color.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                )),
          ],
        ));
  }
}
