import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart';
import 'postagens.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Postagem {
  final String titulo;
  final String descricao;
  final String imagem;
  final String link;
  final String link2;
  final String link3;
  final String linksite;
  final String descricao2;

  Postagem(
      {required this.titulo,
      required this.descricao,
      required this.imagem,
      required this.link,
      required this.descricao2,
      required this.link2,
      required this.link3,
      required this.linksite});

  static where(Function(dynamic postagem) param0) {}
}

class PostagemPage extends StatelessWidget {
  final Postagem postagem;

  PostagemPage({required this.postagem});

  int _opcaoSelecionada = 0;

    Future<List<String>> availableApplications() async {
    if (Platform.isAndroid) {
      return [
        'com.android.chrome',
        'org.mozilla.firefox',
        'com.android.browser',
      ];
    } else {
      return [];
    }
  }

  _launchURL() async {
    final url = postagem.link;
    final List<String> navegadoresDisponiveis = await availableApplications();
    if (navegadoresDisponiveis.isNotEmpty) {
      await launch(url, forceWebView: false);
    } else {
      await launch(url, forceWebView: true);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(postagens: Postagens.lista)),
            );
          } else if (index == 1) {
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(Postagens.lista));
          }
        },
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(postagem.titulo),
        actions: [
          IconButton(
              icon: Icon(Icons.discord),
              onPressed: () async {
                const url = 'https://discord.gg/empire-island';
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Não foi possível abrir o link $url';
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: postagem.imagem,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              SizedBox(height: 30),
              Text(
                postagem.descricao,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  postagem.descricao2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
ElevatedButton.icon(
  onPressed: () async {
    final url = postagem.link;
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
  },
  icon: FaIcon(FontAwesomeIcons.gamepad),
  label: Text('Servidor privado #1'),
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(350, 50)),
  ),
),
              const SizedBox(height: 10),
ElevatedButton.icon(
  onPressed: () async {
    final url = postagem.link2;
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
  },
                icon: FaIcon(FontAwesomeIcons.gamepad),
                label: Text('Servidor privado #2'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(350, 50)),
                ),
              ),
              const SizedBox(height: 10),
ElevatedButton.icon(
  onPressed: () async {
    final url = postagem.link3;
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
  },
                icon: FaIcon(FontAwesomeIcons.gamepad),
                label: Text('Servidor privado #3'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(350, 50)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Servidores cheios? Entre no site para mais servidores vips! Clique no botão:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
ElevatedButton.icon(
  onPressed: () async {
    final url = postagem.linksite;
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
  },
                icon: FaIcon(FontAwesomeIcons.link),
                label: Text(postagem.titulo),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(350, 50)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Para você conseguir acessar os servidores privados é necessário que você tenha 13 anos ou mais.\n\nCaso o seu Roblox informe o erro 524, veja o tutorial abaixo de como resolver:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
ElevatedButton.icon(
  onPressed: () async {
    final url = "https://www.youtube.com/watch?v=kxM4zqkoPMI";
    final availableBrowsers = await availableApplications();
    if (availableBrowsers.isNotEmpty) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      await launch(
        url,
        forceWebView: true,
      );
    }
  },
                icon: FaIcon(FontAwesomeIcons.youtube),
                label: Text('ERRO 524 TUTORIAL'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(350, 50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
