// ignore_for_file: file_names
// ignore_for_file: prefer_const_constructors

import 'package:sistema_pagamento/model/Produto.dart';
import 'package:sistema_pagamento/screens/telaCadastro.dart';
import 'package:sistema_pagamento/utils/produtoHelper.dart';
import 'package:flutter/material.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  List<Produto> listaProdutos = List.empty(growable: true);

  ProdutoHelper db = ProdutoHelper();

  void recuperarProdutos() async {
    List produtosRecuperados = await db.listarProdutos();
    List<Produto> listaTemporaria = List.empty(growable: true);
    for (var produto in produtosRecuperados) {
      Produto obj = Produto(0, "", "", 0);
      obj.toModel(produto);
      listaTemporaria.add(obj);
    }
    setState(() {
      listaProdutos = listaTemporaria;
    });
  }

  void removerProduto(int? id) async {
    await db.excluirProduto(id);
    recuperarProdutos();
  }

  void exibirTelaConfirma(int? id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Excluir Produto"),
            content: Text("Você tem certeza que deseja excluir este produto?"),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    removerProduto(id);
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent),
                  child: Text("Sim")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey),
                  child: Text("Não")),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    recuperarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meus produtos"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: listaProdutos.length,
                    itemBuilder: (context, index) {
                      final Produto p = listaProdutos[index];
                      return Card(
                        child: ListTile(
                          title: Text(p.nome),
                          subtitle: Text(p.preco.toString()),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            GestureDetector(
                              onTap: () {
                                exibirTelaConfirma(p.id);
                              },
                              child: Icon(Icons.delete, color: Colors.blueGrey),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TelaCadastro(produto: p)));
                              },
                              child: Icon(Icons.edit, color: Colors.blueGrey),
                            ),
                          ]),
                        ),
                      );
                    }))
          ],
        ));
  }
}
