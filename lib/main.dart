import 'package:app_ropa/providers/mi_ropa.dart';
import 'package:app_ropa/screens/agregar_ropa_screen.dart';
import 'package:app_ropa/screens/detalle_ropa_screen.dart';
import 'package:app_ropa/screens/editar_ropa_screen.dart';
import 'package:app_ropa/screens/lista_ropa_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MiRopa(),
      child: MaterialApp(
        title: 'Mi Ropa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        home: ListaRopaScreen(),
        routes: {
          AgregarRopaScreen.routeName: (context) => AgregarRopaScreen(),
          DetalleRopaScreen.routeName: (context) => DetalleRopaScreen(),
          EditarRopaScreen.routeName: (context) => EditarRopaScreen(),
        },
      ),
    );
  }
}
