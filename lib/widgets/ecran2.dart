import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ecran2 extends StatefulWidget {
  const Ecran2({Key? key}) : super(key: key);

  @override
  _Ecran2State createState() => _Ecran2State();
}

class _Ecran2State extends State<Ecran2> {
  List<dynamic> jsonData = [];
  int rowsPerPage = 10;
  int currentPage = 0;
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
      if (book.containsKey('Genre')) {
        genresSet.add(book['Genre']);
      }
    }
    return genresSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Genres'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Nombre de colonnes dans la grille
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: genresList.length,
              itemBuilder: (context, index) {
                String genre = genresList[index];
                int count = jsonData.where((book) => book['Genre'] == genre).length;
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
            BottomAppBar(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Nombre de tableaux disponibles : ${jsonData.length}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
