import 'package:crypto_coin/moedas/moeda.dart';
import 'package:crypto_coin/pages/moedas_detalhes_page.dart';
import 'package:crypto_coin/repositories/favoritas_repository.dart';
import 'package:crypto_coin/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //pacote para formartar os valor monetário
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  MoedasPage({super.key});

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  //acessando a tabela e atribuindo a var tabela (final = não vai mudar)
  final tabela = MoedaRepository.tabela;
  //formatando o valor monetário das cryptomoedas
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  // lista criada para implementar a funcao de selecionar as opcoes
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  AppBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Cripto Moedas'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        /*textTheme: TextTheme(
          headline:TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),*/
      );
    }
  }

  //com o material pageroute a pagina e o botao de volta já é criado
  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<FavoritasRepository>(context);
    //favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
        appBar: AppBarDinamica(),
        //mostrando os itens da classe moeda repository na tela da classa moedas page
        body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),),
              leading: (selecionadas.contains(tabela[moeda]))
                  ? CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      child: Image.asset(tabela[moeda].icone),
                      width: 40,
                    ),
              title: Row(
                    children: [
                      Text(
                        tabela[moeda].nome,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if(favoritas.lista.contains(tabela[moeda]))
                        Icon(Icons.star, color: Colors.blue, size: 8,)
                    ],
                  ), 
              trailing: Text(
                real.format(tabela[moeda].preco),
                style: TextStyle(fontSize:15),
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
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
           //o flutter precisa saber qual o tamanho da lista pra poder rendereizar
          itemCount: tabela.length,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selecionadas.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  favoritas.saveAll(selecionadas);
                  limparSelecionadas();
                },
                icon: Icon(Icons.star),
                label: Text(
                        'FAVORITAR',
                        style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                )
            : null);
  }
}
