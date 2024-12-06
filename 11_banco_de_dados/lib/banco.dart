import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Banco extends StatefulWidget {
  const Banco({super.key});

  @override
  State<Banco> createState() => _BancoState();
}

class _BancoState extends State<Banco> {

  _recuperarBancoDados() async{

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersaoRecente){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER) ";
          db.execute(sql);
        }
    );
    print("aberto: " + bd.isOpen.toString());
    return bd;

  }

  _salvar() async {

    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome":"Saiomaria",
      "idade": 26,
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
  }

  _listarUsuarios() async {

    Database bd = await _recuperarBancoDados();

    // String sql = "SELECT * FROM usuarios WHERE idade = 30" ;
    // String sql = "SELECT * FROM usuarios WHERE nome LIKE 'Matheus%' " ;
    String sql = "SELECT * FROM usuarios" ;
    List usuarios = await bd.rawQuery(sql);

    for ( var usuario in usuarios ){
      print(
        "item id: "+ usuario['id'].toString()+
          " nome: " + usuario['nome']+
            " idade: " + usuario['idade'].toString()
      );
    }
    // print("usuarios: "+usuarios.toString());
  }

  _recuperarUsuarioPeloId(int id) async {

    Database bd = await _recuperarBancoDados();

    List usuarios = await bd.query(
      "usuarios",
      columns: ["id","nome","idade"],
      where: "id = ? ",
      whereArgs: [id]
    );

    for ( var usuario in usuarios ){
      print(
          "item id: "+ usuario['id'].toString()+
              " nome: " + usuario['nome']+
              " idade: " + usuario['idade'].toString()
      );
    }

  }

  _excluirUsuario(int id) async{

    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete(
      "usuarios",
      where: "nome = ?",
      whereArgs: ["Saiomaria alterado"]
    );
  }

  _updateUsuario(int id) async{

    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome":"Matheus Lula",
      "idade": 21,
    };

    int retorno = await bd.update(
        "usuarios",
        dadosUsuario,
      where: "id = ?",
      whereArgs: [id],
    );

  }


  @override
  Widget build(BuildContext context) {
    // _recuperarBancoDados();
    // _salvar();
    // _recuperarUsuarioPeloId(3);
    // _excluirUsuario(12);
    // _updateUsuario(13);
    _listarUsuarios();

    return Container();
  }
}
