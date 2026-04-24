import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CasinoHome(),
    );
  }
}

class CasinoHome extends StatefulWidget {
  @override
  _CasinoHomeState createState() => _CasinoHomeState();
}

class _CasinoHomeState extends State<CasinoHome> {
  List<String> symbols = ["🍒","🍋","🍊","⭐","💎"];
  List<String> result = ["🍒","🍋","🍊"];

  void spin() {
    final rand = Random();
    setState(() {
      result = [
        symbols[rand.nextInt(symbols.length)],
        symbols[rand.nextInt(symbols.length)],
        symbols[rand.nextInt(symbols.length)],
      ];
    });

    if (result[0] == result[1] && result[1] == result[2]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("🎉 You Win!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Casino App 🎰")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(result.join(" "), style: TextStyle(fontSize: 50)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: spin,
            child: Text("SPIN"),
          ),
        ],
      ),
    );
  }
}
