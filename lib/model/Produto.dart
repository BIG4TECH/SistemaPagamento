// ignore_for_file: prefer_const_constructors
// ignore_for_file: file_names

class Produto{
  int? id;
  String nome;
  String marca;
  double preco;

  Produto(this.id, this.nome, this.marca, this.preco);

  Map<String, dynamic> toMap(){
    // ignore: prefer_collection_literals
    var dados = Map<String, dynamic>();
    dados['id'] = id;
    dados['nome'] = nome;
    dados['marca'] = marca;
    dados['preco'] = preco;

    return dados;
  }

  toModel(Map<String, dynamic> dados){
    id = dados['id'];
    nome = dados['nome'];
    marca = dados['marca'];
    preco = dados['preco'];
  }
}