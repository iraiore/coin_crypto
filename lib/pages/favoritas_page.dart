import 'package:crypto_coin/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_coin/widgets/moeda_card.dart';

class FavoritasPage extends StatefulWidget {
  FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Favoritas'),
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          padding: EdgeInsets.all(12.0),
          //Consumer - consumindo o provider
          child: Consumer<FavoritasRepository>(
            builder: (context, favoritas, child) {
              return favoritas.lista.isEmpty
                  ? ListTile(
                      leading: Icon(Icons.star),
                      title: Text('Ainda não há moedas favoritas'),
                    )
                  : ListView.builder(
                      itemCount: favoritas.lista.length,
                      itemBuilder: (_, index) {
                        return MoedaCard(moeda: favoritas.lista[index]);
                      },);
            },
          )),
    );
  }
}
