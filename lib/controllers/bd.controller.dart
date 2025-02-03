import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> abrirBanco() async {
  var dataBasePath = await getDatabasesPath();
  String path = join(dataBasePath, "contatos.db");

  var bd = await openDatabase(path, version: 1, onCreate: (db, versao) async {
    String sql =
        "Create table contato (id integer primary key autoincrement, nome varchar, descricao varchar, imagem varchar, latitude real, longitude real)";
    await db.execute(sql);
  });

  return bd;
}