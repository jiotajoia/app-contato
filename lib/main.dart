import 'package:flutter/material.dart';
import 'package:trabalho_final/views/contatos.dart';
import 'package:trabalho_final/views/homePage.dart';
import 'package:trabalho_final/views/login.dart';
import 'package:trabalho_final/views/mapas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/homepage" : (context) => HomePage(),
        "/contatos" : (context) => Contatos(),
        "/mapas" : (context) => Mapas(),
      },
      debugShowCheckedModeBanner: false,

      
    );
  }
}