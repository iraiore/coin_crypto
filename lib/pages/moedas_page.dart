import 'package:crypto_coin/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatelessWidget {
  const MoedasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository.tabela; //acessando a tabela e atribuindo a var tabela (final = não vai mudar)

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blue,
          title: Text('Crypto Moedas'),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int moeda){
              return ListTile(
                leading: Image.asset(tabela[moeda].icone),
                title: Text(tabela[moeda].nome),
                trailing: Text(tabela[moeda].preco.toString()),
              );
            },
            padding: EdgeInsets.all(16),
            separatorBuilder: (_,__) => Divider(),
            itemCount: tabela.length,),);
  }
}
