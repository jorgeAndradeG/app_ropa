import 'dart:io';

import 'package:app_ropa/providers/mi_ropa.dart';
import 'package:app_ropa/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class EditarRopaScreen extends StatefulWidget {
  static const routeName = 'editar_ropa';
  @override
  _EditarRopaScreenState createState() => _EditarRopaScreenState();
}

class _EditarRopaScreenState extends State<EditarRopaScreen> {
  final marcaController = TextEditingController();
  final tallaController = TextEditingController();
  final precioController = TextEditingController();
  final materialController = TextEditingController();
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  File _imagenSel;

  void seleccionarImagen(File imagenSel) {
    _imagenSel = imagenSel;
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void guardarRopa(int viejaId) {
    if (marcaController.text.isEmpty ||
        tallaController.text.isEmpty ||
        precioController.text.isEmpty ||
        materialController.text.isEmpty ||
        pickerColor == null ||
        _imagenSel == null ||
        int.parse(precioController.text) <= 0) {
      return;
    }

    Provider.of<MiRopa>(context, listen: false).editarRopa(
      viejaId,
      marcaController.text,
      tallaController.text,
      pickerColor.toString(),
      _imagenSel,
      materialController.text,
      int.parse(precioController.text),
    );
    Navigator.of(context).pop();
    ChangeNotifier();
  }

  @override
  Widget build(BuildContext context) {
    final int viejaId = ModalRoute.of(context).settings.arguments;
    final ropaSel =
        Provider.of<MiRopa>(context, listen: false).encontrarConId(viejaId);
    marcaController.text = ropaSel.marca;
    tallaController.text = ropaSel.talla;
    precioController.text = ropaSel.precio.toString();
    materialController.text = ropaSel.material;
    _imagenSel = ropaSel.imagen;
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar prenda'),
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
                    RaisedButton(
                      child: Text('Elegir Color'),
                      color: pickerColor,
                      onPressed: () => showDialog(
                          context: context,
                          child: AlertDialog(
                            title: const Text('Elige color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Listo'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Precio',
                      ),
                      controller: precioController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(() => seleccionarImagen(_imagenSel)),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            onPressed: () => guardarRopa(viejaId),
            label: Text('Editar Datos'),
            color: Theme.of(context).canvasColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
