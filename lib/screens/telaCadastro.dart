// ignore_for_file: prefer_const_constructors, file_names
import 'package:sistema_pagamento/model/Produto.dart';
import 'package:sistema_pagamento/screens/home.dart';
import 'package:sistema_pagamento/utils/produtoHelper.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
  Produto? produto;

  TelaCadastro({this.produto});
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController txtnome = TextEditingController();
  TextEditingController txtmarca = TextEditingController();
  TextEditingController txtpreco = TextEditingController();

  ProdutoHelper db = ProdutoHelper();
  String textBotao = "Adicionar Produto";
  String textAppBar = "Cadastro de Produtos";
  int? idProduto;

  void salvarProduto({Produto? produto}) async {
    if (produto == null) {
      Produto obj = Produto(
          null, txtnome.text, txtmarca.text, double.parse(txtpreco.text));
      int? resultado = await db.cadastrarProduto(obj);
      setState(() {
        if (resultado != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    } else {
      produto.nome = txtnome.text;
      produto.marca = txtmarca.text;
      produto.preco = double.parse(txtpreco.text);
      produto.id = idProduto;
      int? resultado = await db.alterarProduto(produto);
      setState(() {
        if (resultado != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) {
      txtnome.text = widget.produto!.nome;
      txtmarca.text = widget.produto!.marca;
      txtpreco.text = widget.produto!.preco.toString();
      idProduto = widget.produto!.id;

      textBotao = "Editar Produto";
      textAppBar = "Edição de Produto";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textAppBar),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: null,
            child: Column(
              children: [
                TextFormField(
                  controller: txtnome,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Nome"),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtmarca,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Marca"),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtpreco,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Preço"),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      salvarProduto(produto: widget.produto);
                    },
                    child: Text(textBotao),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
