import "package:flutter/material.dart";

class CustomSearchDelegate extends SearchDelegate<String>{

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(
         onPressed: (){
           query = "";
         },
         icon: Icon(Icons.clear),
     ),
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   // print("A pesquisa esta sendo realizada");
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    /*
    List<String> lista = []; // Inicializa a lista como vazia
    if (query.isNotEmpty) {
      // Filtra a lista com base na query
      lista = [
        "Computador",
        "PS5",
        "Windows!"
      ].where(
          (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList(); // Filtra com base na query
    }

    // Se a lista estiver vazia, exibe a mensagem
    if (lista.isEmpty) {
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: (){
            close(context, lista[index]);
          },
          title: Text(lista[index]),
        );
      },
    );*/
  }

}