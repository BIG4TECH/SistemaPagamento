// ignore_for_file: prefer_const_constructors

import 'package:sistema_pagamento/screens/widgets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: menuDrawer(context),
    );
  }
}
