// ============================================================================
// TP2 - Aplicativo de Preferências Musicais
// Autores: Yohans Silva Bezerra & Luiz Henrique
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppMusica());
}

class MeuAppMusica extends StatelessWidget {
  const MeuAppMusica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências Musicais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

class GeneroMusical {
  final String id;
  final String nome;
  final String descricao;
  final String imagemUrl;
  bool curte;
  double volumePreferido;
  bool receberRecomendacoes;

  GeneroMusical({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagemUrl,
    this.curte = false,
    this.volumePreferido = 50.0,
    this.receberRecomendacoes = false,
  });
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final List<GeneroMusical> _listaGeneros = [
    GeneroMusical(
      id: '1',
      nome: 'Rock',
      descricao:
          'Gênero musical popular focado em guitarras elétricas, baixo e bateria. Teve origem no rock and roll dos anos 1950.',
      imagemUrl: 'https://picsum.photos/id/145/200/200',
    ),
    GeneroMusical(
      id: '2',
      nome: 'Pop',
      descricao:
          'Estilo de música comercial que enfatiza estruturas de canções memoráveis, melodias cativantes e ritmos dançantes.',
      imagemUrl: 'https://picsum.photos/id/1082/200/200',
    ),
    GeneroMusical(
      id: '3',
      nome: 'Jazz',
      descricao:
          'Originado em Nova Orleans, é marcado pelo uso ostensivo de improvisação, sincopação e ritmos complexos.',
      imagemUrl: 'https://picsum.photos/id/453/200/200',
    ),
    GeneroMusical(
      id: '4',
      nome: 'Música Clássica',
      descricao:
          'Tradição musical ocidental orquestral e de câmara que abrange do período medieval aos dias de hoje.',
      imagemUrl: 'https://picsum.photos/id/334/200/200',
    ),
    GeneroMusical(
      id: '5',
      nome: 'Hip-Hop',
      descricao:
          'Cultura e gênero originado no Bronx na década de 1970, caracterizado por batidas marcantes, DJing e rap.',
      imagemUrl: 'https://picsum.photos/id/1025/200/200',
    ),
    GeneroMusical(
      id: '6',
      nome: 'Música Eletrônica',
      descricao:
          'Gênero que emprega instrumentos musicais eletrônicos e tecnologia em sua produção, famoso pela cultura clubber.',
      imagemUrl: 'https://picsum.photos/id/367/200/200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências - Yohans & Luiz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: _listaGeneros.length,
        itemBuilder: (context, index) {
          final genero = _listaGeneros[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  genero.imagemUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.music_note, size: 40),
                ),
              ),
              title: Text(
                genero.nome,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                genero.curte ? 'Você gosta deste gênero' : 'Não favoritado',
                style: TextStyle(
                  color: genero.curte ? Colors.green[700] : Colors.grey[600],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Gosto:'),
                  Switch(
                    value: genero.curte,
                    onChanged: (bool valor) {
                      setState(() {
                        genero.curte = valor;
                      });
                    },
                  ),
                ],
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaConfiguracoesGenero(genero: genero),
                  ),
                );
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
