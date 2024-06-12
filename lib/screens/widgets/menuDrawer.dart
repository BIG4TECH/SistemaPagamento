// ignore_for_file: prefer_const_constructors, file_names

import 'package:sistema_pagamento/screens/telaCadastro.dart';
import 'package:sistema_pagamento/screens/telaProdutos.dart';
import 'package:flutter/material.dart';

Widget menuDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          height: 230,
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Minha Lista de Produtos",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Desenvolvido por BIG4TECH",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.add,
            color: Colors.blueGrey,
          ),
          title: Text(
            "Novo produto",
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductRegisterScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.food_bank, color: Colors.blueGrey),
          title: Text(
            "Meus produtos",
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductListScreen()));
          },
        )
      ],
    ),
  );
}
