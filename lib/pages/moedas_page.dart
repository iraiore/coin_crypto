import 'package:crypto_coin/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';//pacote para formartar os valor monetário

class MoedasPage extends StatelessWidget {
  const MoedasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository
        .tabela; //acessando a tabela e atribuindo a var tabela (final = não vai mudar)
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');//formatando o valor monetário das cryptomoedas

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        title: Text('Crypto Moedas'),
      ),
      //mostrando os itens da classe moeda repository na tela da classa moedas page
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            leading: SizedBox(
              child: Image.asset(tabela[moeda].icone),
              width: 40,
            ),
            title: Text(
              tabela[moeda].nome,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(real.format(tabela[moeda].preco),),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela
            .length, //o flutter precisa saber qual o tamanho da lista pra poder rendereizar
      ),
    );
  }
}
