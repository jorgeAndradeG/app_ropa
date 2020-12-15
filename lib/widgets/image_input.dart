import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImagen;
  ImageInput(this.onSelectImagen);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File imagenGuardada;
  final _picker = ImagePicker();

  Future<void> tomarFoto() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedFile == null) {
      return null;
    }
    final File file = File(pickedFile.path);
    setState(() {
      imagenGuardada = file;
    });
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); //accedo a carpeta del dispositivo
    final fileName = path.basename(file.path);
    final savedImage = await file.copy('${appDir.path}/$fileName');
    widget.onSelectImagen(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 1, //border: 1px solid grey
          )),
          child: imagenGuardada != null
              ? Image.file(
                  imagenGuardada,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'Ninguna imagen tomada',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            onPressed: tomarFoto,
            icon: Icon(Icons.camera),
            label: Text('Tomar Foto'),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
