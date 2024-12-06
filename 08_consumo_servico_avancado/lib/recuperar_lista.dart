import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'post.dart';

class RecuperarLista extends StatefulWidget {
  const RecuperarLista({super.key});

  @override
  State<RecuperarLista> createState() => _RecuperarListaState();
}

class _RecuperarListaState extends State<RecuperarLista> {

  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _RecuperarPostagens() async{

    http.Response response = await http.get(Uri.parse(_urlBase + "/posts"));
    var dadosJson = json.decode (response.body);

    List<Post> postagens = [];

    for(var post in dadosJson){
      print ("post: " + post["title"]);
      Post p = Post(post["userId"],post["id"],post["title"],post["body"]);
      postagens.add(p);
    }
    return postagens;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Post>>(
          future: _RecuperarPostagens(),
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
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      List<Post>? lista = snapshot.data;
                      Post post = lista![index];

                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    },
                  );
                }
            }
          }
      ),
    );
  }
}
