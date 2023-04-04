import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'postagem.dart';
import 'postagens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameCodes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(postagens: Postagens.lista),
    );
  }
}

List<Widget> pages = [ PrivacyPage(),];


class HomePage extends StatelessWidget {
  final List<Postagem> postagens;

  HomePage({required this.postagens});

  int _opcaoSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 800),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(postagens: Postagens.lista)),
            );
          } else if (index == 1) {
            _opcaoSelecionada = index;
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(postagens));
          } else if (index == 2) {
  _opcaoSelecionada = index;
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PrivacyPage()),
  );
          }
        },
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.info_outline, size: 30, color: Colors.white),
        ],
      ),
      appBar: AppBar(
        title: Text('GameCodes - Servidores Privados'),
        actions: [
          IconButton(
              icon: Icon(Icons.discord),
              onPressed: () async {
                const url = 'https://discord.gg/empire-island';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Não foi possível abrir o link $url';
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              children: List.generate(postagens.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostagemPage(postagem: postagens[index])),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          child: Image.network(postagens[index].imagem),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(postagens[index].titulo,
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(postagens[index].descricao),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Postagem> postagens;

  CustomSearchDelegate(this.postagens);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Postagem> matchQuery = postagens
        .where((postagem) =>
            postagem.titulo.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (matchQuery.length == 0) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/imagens/error.png'),
              const SizedBox(height: 50),
              const Text(
                'Nenhum resultado encontrado. Verifique se digitou corretamente, caso o jogo não esteja listado deixe uma sugestão em nosso servidor do Discord.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          final postagem = matchQuery[index];
          return Container(
            padding: const EdgeInsets.all(16), // define o padding em torno do Card
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  8), // define o radius das bordas do Card
              border: Border.all(
                  color: Colors.grey[300]!), // define a cor da borda do Card
            ),
            child: Card(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: postagem.imagem,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  ListTile(
                    title: Text(postagem.titulo),
                    subtitle: Text(postagem.descricao),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostagemPage(postagem: postagem)),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Postagem> matchQuery = postagens
        .where((postagem) =>
            postagem.titulo.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final postagem = matchQuery[index];
        return ListTile(
          title: Text(postagem.titulo),
          subtitle: Text(postagem.descricao),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostagemPage(postagem: postagem)),
            );
          },
        );
      },
    );
  }
}

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

  int _opcaoSelecionada = 0;

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 800),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(postagens: Postagens.lista)),
            );
          } else if (index == 1) {
            _opcaoSelecionada = index;
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(Postagens.lista));
          } else if (index == 2) {
  _opcaoSelecionada = index;
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PrivacyPage()),
  );
          }
        },
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
        ],
      ),
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      const Text(
        '',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      ElevatedButton.icon(
              onPressed: () async {
                const url = 'https://www.gamecodesbrasil.xyz/p/politica-de-privacidade-privacy-policy.html';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Não foi possível abrir o link $url';
                }
              },
        icon: const Icon(Icons.info),
        label: const Text('Privacy Policy'),
          style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
  ),
      ),
                      ],
                ),
    ),
    );
  }
}
