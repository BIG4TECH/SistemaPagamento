// ignore_for_file: file_names
// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:sistema_pagamento/model/Produto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoHelper {
  static late Database banco;

  ProdutoHelper();

  void criaBanco(Database db, int version) async {
    String sql = """CREATE TABLE IF NOT EXISTS tb_produtos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      marca TEXT,
      preco FLOAT
    )""";
    await db.execute(sql);
  }

  Future<Database> inicializaBanco() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + 'bdprodutos.db';
    banco = await openDatabase(caminho, version: 1, onCreate: criaBanco);
    return banco;
  }

  Future<int> cadastrarProduto(Produto obj) async {
    Database db = await inicializaBanco();
    var resposta = await db.insert('tb_produtos', obj.toMap());
    return resposta;
  }

  listarProdutos() async {
    Database db = await inicializaBanco();
    String sql = "SELECT * FROM tb_produtos";
    List lista = await db.rawQuery(sql);
    return lista;
  }

  Future<int> excluirProduto(int? id) async {
    Database db = await inicializaBanco();
    var resposta =
        await db.delete('tb_produtos', where: "id=?", whereArgs: [id]);
    return resposta;
  }

  Future<int> alterarProduto(Produto obj) async {
    Database db = await inicializaBanco();
    var resposta = await db
        .update('tb_produtos', obj.toMap(), where: "id=?", whereArgs: [obj.id]);
    return resposta;
  }
}
