import 'dart:ffi';

import 'package:crypto_coin/pages/favoritas_page.dart';
import 'package:crypto_coin/pages/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    pc = PageController(initialPage: paginaAtual);
  }
  //seta a pagina quando éla é alterada e o curretindex do botton navigation é alterado
  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          MoedasPage(),
          FavoritasPage(),
        ],
        //propriedade do PageView que altera toda vez que pagview for alterada. O icone todas fica roxo sempre (corrigi esse prob )
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas')
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
