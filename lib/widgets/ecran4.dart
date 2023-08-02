import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ecran4 extends StatefulWidget {
  const Ecran4({Key? key}) : super(key: key);

  @override
  _Ecran4State createState() => _Ecran4State();
}

class _Ecran4State extends State<Ecran4> {
  List<dynamic> jsonData = [];
  int genresPerPage = 10; // Nombre de localisations à afficher par page
  List<String> genresList = [];

  @override
  void initState() {
    super.initState();
    _chargerDonnees();
  }

  Future<void> _chargerDonnees() async {
    try {
      // Charger le contenu du fichier JSON à l'aide de rootBundle
      String data = await rootBundle.loadString('data/livres.json');

      // Convertir le contenu JSON en une liste d'objets Dart
      setState(() {
        jsonData = jsonDecode(data);
        genresList = _extractGenres(jsonData);
      });
    } catch (e) {
      // Gérer les erreurs éventuelles
      print('Erreur lors du chargement des données : $e');
    }
  }

  List<String> _extractGenres(List<dynamic> jsonData) {
    Set<String> genresSet = Set();
    for (var book in jsonData) {
      if (book.containsKey('localisation')) {
        genresSet.add(book['localisation']);
      }
    }
    return genresSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les localisations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Nombre de colonnes dans la grille
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: (genresList.length / genresPerPage).ceil() * genresPerPage,
              itemBuilder: (context, index) {
                if (index >= genresList.length) {
                  return SizedBox.shrink();
                }
                String genre = genresList[index];
                int count = jsonData.where((book) => book['localisation'] == genre).length;
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('$genre ($count livres)'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Nombre de localisations : ${genresList.length}'),
        ),
      ),
    );
  }
}
