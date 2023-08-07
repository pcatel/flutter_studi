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
  int genresPerPage = 10; // Nombre de genres à afficher par page
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Nombre de colonnes dans la grille
                      crossAxisSpacing: 32.0,
                      mainAxisSpacing: 32.0,
                    ),
                    itemCount: (genresList.length / genresPerPage).ceil() *
                        genresPerPage,
                    itemBuilder: (context, index) {
                      if (index >= genresList.length) {
                        return SizedBox.shrink();
                      }
                      String genre = genresList[index];
                      int count = jsonData
                          .where((book) => book['Genre'] == genre)
                          .length;
                      String imagePath =
                          'assets/images/Genres/${genre.toLowerCase()}.jpg';

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.20),
                        child: Card(
                          child: Container(
                          
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.center,
                            child:
                              
                             
                                Column(
                                  children: [
                                    Text(
                                      genre,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '($count titres)',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              
                          
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
