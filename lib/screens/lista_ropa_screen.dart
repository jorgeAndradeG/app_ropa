import 'package:app_ropa/providers/mi_ropa.dart';
import 'package:app_ropa/screens/agregar_ropa_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detalle_ropa_screen.dart';

class ListaRopaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Prendas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AgregarRopaScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<MiRopa>(context, listen: false).getRopa(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<MiRopa>(
                  child: Center(
                    child: Text('Comienza agregando nueva ropa'),
                  ),
                  builder: (context, miRopa, ch) => miRopa.items.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: miRopa.items.length,
                          itemBuilder: (context, i) => Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Se eliminó ${miRopa.items[i].marca}'))); //CAMBIAR POR EL ÍCONO
                                  Provider.of<MiRopa>(context, listen: false)
                                      .eliminarRopa(miRopa.items[i].id);
                                },
                                background: Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                      miRopa.items[i].imagen,
                                    ),
                                  ),
                                  title: Text(miRopa.items[i].marca),
                                  subtitle: Text('${miRopa.items[i].id}'),
                                  onTap: () => Navigator.of(context).pushNamed(
                                      DetalleRopaScreen.routeName,
                                      arguments: miRopa.items[i].id),
                                ),
                              )),
                )),
    );
  }
}
