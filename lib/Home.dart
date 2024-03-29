import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map> _recuperarPreco() async {
    var url = Uri.parse("https://blockchain.info/pt/ticker");
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot) {
        String resultado = "";
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            print("conexao awaiting");
            resultado = "Carregando...";
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            print("conexao done");
            if (snapshot.hasError) {
              resultado = "erro ao carregar os dados";
            } else {
              double valor = snapshot.data?["BRL"]["buy"];
              resultado = "preço do bitcoin: ${valor.toString()}";
            }
            break;
        }
        return Center(
          child: Text(resultado),
        );
      },
    );
  }
}
