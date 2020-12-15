import 'dart:io';
import 'package:app_ropa/providers/mi_ropa.dart';
import 'package:app_ropa/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarRopaScreen extends StatefulWidget {
  static const routeName = 'agregar_ropa';
  @override
  _AgregarRopaScreenState createState() => _AgregarRopaScreenState();
}

class _AgregarRopaScreenState extends State<AgregarRopaScreen> {
  final marcaController = TextEditingController();
  final tallaController = TextEditingController();
  final precioController = TextEditingController();
  final materialController = TextEditingController();
  final colorController = TextEditingController();
  File _imagenSel;

  void seleccionarImagen(File imagenSel) {
    _imagenSel = imagenSel;
  }

  void guardarRopa() {
    if (marcaController.text.isEmpty ||
        tallaController.text.isEmpty ||
        precioController.text.isEmpty ||
        materialController.text.isEmpty ||
        colorController.text.isEmpty ||
        _imagenSel == null ||
        int.parse(precioController.text) <= 0) {
      return;
    }

    Provider.of<MiRopa>(context, listen: false).agregarRopa(
      marcaController.text,
      tallaController.text,
      colorController.text,
      _imagenSel,
      materialController.text,
      int.parse(precioController.text),
    );
    Navigator.of(context).pop();
    ChangeNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir prenda'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Talla',
                      ),
                      controller: tallaController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Marca',
                      ),
                      controller: marcaController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Color',
                      ),
                      controller: colorController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Material',
                      ),
                      controller: materialController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Precio',
                      ),
                      controller: precioController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(seleccionarImagen),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            onPressed: guardarRopa,
            label: Text('Agregar Prenda'),
            color: Theme.of(context).canvasColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
