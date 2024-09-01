import 'package:crypto_coin/moedas/moeda.dart';
import 'package:crypto_coin/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //pacote para formartar os valor monetário

class MoedasPage extends StatefulWidget {
  MoedasPage({super.key});

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  //acessando a tabela e atribuindo a var tabela (final = não vai mudar)
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  //formatando o valor monetário das cryptomoedas
  List<Moeda> selecionadas =
      []; // lista criada para implementar a funcao de selecionar as opcoes

  AppBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cripto Moedas'),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas')
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDinamica(),
      //mostrando os itens da classe moeda repository na tela da classa moedas page
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
            leading: (selecionadas.contains(tabela[moeda]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
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
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              //verificando se já existem itens selecionados e removendo quando pressionados
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
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
