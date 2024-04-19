import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistema_pagamento/screens/telaCadastroPessoa.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SignupScreen()));
}
