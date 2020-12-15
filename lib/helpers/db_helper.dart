import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database db;

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mi_ropa.db'); //ruta donde está la BD
    db = await openDatabase(path, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE mi_ropa(id INTEGER PRIMARY KEY AUTOINCREMENT, talla TEXT, marca TEXT, color TEXT, material TEXT, precio INTEGER, imagen TEXT)');
    }, version: 1);
    return db;
  }

  Future<void> insertar(String tabla, Map<String, Object> data) async {
    final db = await initDB();
    db.insert(tabla, data,
        conflictAlgorithm: ConflictAlgorithm
            .replace //reemplaza el registro por si existe uno con el mismo id, en este caso no aplica porque la id es autogenerada
        );
  }

  Future<List<Map<String, dynamic>>> obtenerDatos(String tabla) async {
    final db = await initDB();
    return db.query(tabla);
  }

  Future<void> eliminar(String tabla, int id) async {
    final db = await initDB();
    db.delete(tabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(String tabla, Map<String, Object> data, int id) async {
    final db = await initDB();
    db.update(
      tabla,
      data,
      where: 'id =?',
      whereArgs: [id],
    );
  }
}
