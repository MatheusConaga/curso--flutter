import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            "images/logo.png",
            fit: BoxFit.contain,
          ),
            Expanded(
                child: Container(),
            ),

            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.search)
            ),
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.shopping_cart_rounded)
            ),

          SizedBox(
            width: 10,
          ),

          OutlinedButton(
              onPressed: (){

              },
              child: Text("Cadastrar"),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            width: 10,
          ),

          OutlinedButton(
            onPressed: (){

            },
            child: Text("Entrar"),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),

        ],
      ),
    );
  }
}
