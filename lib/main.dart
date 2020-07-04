import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "Clique no botão e confira o preço do bitcoin";

  void calculate() async {

    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);

    Map<String, dynamic> res = json.decode(response.body);

    setState(() {
      _preco = "R\$${res["BRL"]["buy"].toString()}";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 50, top: 200),
                child: Image.asset("images/bitcoin.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                   _preco,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: calculate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
