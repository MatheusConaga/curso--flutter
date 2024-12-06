import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future <Map> _RecuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preço Bitcoin"),
      ),
      body: FutureBuilder<Map>(
          future: _RecuperarPreco(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text("Erro ao conectar."));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Center(child: Text("Carregando..."));
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(child: Text("Erro ao carregar dados."));
                } else if (snapshot.hasData) {
                  Map? preco = snapshot.data;
                  return Center(
                    child: Text(
                      "Preço do Bitcoin: ${preco!['BRL']['buy'].toString()}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return const Center(child: Text("Nenhum dado disponível."));
                }
            }

          }
      ),
    );
  }
}
