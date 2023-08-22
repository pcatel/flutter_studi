import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'drawer.dart';

import 'ficheLivre.dart'; // Importez la classe FichePage depuis le fichier fiche.dart
import 'livre.dart'; // Importez la classe Livre depuis le fichier livre.dart
import 'button_navigation.dart';

class Ecran5 extends StatefulWidget {
  const Ecran5({Key? key}) : super(key: key);

  @override
  _Ecran5State createState() => _Ecran5State();
}

class _Ecran5State extends State<Ecran5> {
  List<Livre> livres = [];
  List<Livre> resultatsRecherche = [];
  String critereRecherche = 'livre';
  String texteRecherche = '';
  bool afficherMessagePasDeLivres = false;
  int currentPage = 1; // Numéro de la page actuelle
  int itemsPerPage = 12; // Nombre d'éléments par page

  @override
  void initState() {
    super.initState();
    _chargerLivres();
  }

  Future<void> _chargerLivres() async {
    final String jsonString = await rootBundle.loadString('data/livres.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      livres = jsonData.map((data) => Livre.fromJson(data)).toList();
    });
  }

  void _rechercher() {
    setState(() {
      _chargerResultatsRecherche();
    });
  }

  void _chargerResultatsRecherche() {
    if (critereRecherche == 'livre') {
      resultatsRecherche = livres
          .where((livre) =>
              livre.titre.toLowerCase().contains(texteRecherche.toLowerCase()))
          .toList();
    } else if (critereRecherche == 'auteur') {
      resultatsRecherche = livres
          .where((livre) =>
              livre.nomAuteur.toLowerCase().contains(texteRecherche.toLowerCase()))
          .toList();
    } else if (critereRecherche == 'localisation') {
      resultatsRecherche = livres
          .where((livre) =>
              livre.localisation.toLowerCase().contains(texteRecherche.toLowerCase()))
          .toList();
    } else {
      resultatsRecherche = [];
    }

    afficherMessagePasDeLivres =
        (texteRecherche.isNotEmpty && resultatsRecherche.isEmpty);
  }

  void _ouvrirFicheLivre(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FichePage(livre: livre)), // Afficher la page de la fiche du livre
    );
  }

  Widget _getHighlightedTextWidget(String text) {
    final highlightedText = texteRecherche.isNotEmpty &&
            text.toLowerCase().contains(texteRecherche.toLowerCase())
        ? RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: _getHighlightSpans(text, texteRecherche),
            ),
          )
        : Text(text);
    return highlightedText;
  }

  List<TextSpan> _getHighlightSpans(String text, String pattern) {
    final List<TextSpan> spans = [];
    int start = 0;

    final patternRegExp = RegExp(pattern, caseSensitive: false);

    final matches = patternRegExp.allMatches(text);

    for (final match in matches) {
      if (start != match.start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      final highlightedText = TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );

      spans.add(highlightedText);

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start, text.length)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    // Calculez le nombre total de pages en fonction du nombre de résultats de recherche et du nombre d'éléments par page
    int totalPages = (resultatsRecherche.length / itemsPerPage).ceil();

    // Calculez l'index de début et de fin des éléments à afficher sur la page actuelle
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > resultatsRecherche.length) {
      endIndex = resultatsRecherche.length;
    }

    return Scaffold(
      drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => texteRecherche = value),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un livre, auteur ou localisation...',
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () => _rechercher(),
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF430C05),
                    elevation: 20,
                    shadowColor: Colors.amber,
                  ),
                  child: Icon(Icons.search, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Remplacez DropdownButton par des boutons radio
            Row(
              children: [
                Radio<String>(
                  value: 'livre',
                  groupValue: critereRecherche,
                  onChanged: (value) => setState(() {
                    critereRecherche = value!;
                  }),
                ),
                Text('Titre'),
                Radio<String>(
                  value: 'auteur',
                  groupValue: critereRecherche,
                  onChanged: (value) => setState(() {
                    critereRecherche = value!;
                  }),
                ),
                Text('Nom Auteur'),
                Radio<String>(
                  value: 'localisation',
                  groupValue: critereRecherche,
                  onChanged: (value) => setState(() {
                    critereRecherche = value!;
                  }),
                ),
                Text('Localisation'),
              ],
            ),
            const SizedBox(height: 16),
            if (resultatsRecherche.isNotEmpty)
              Container(
                width: double.infinity,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color(0xFFD46F4D)),
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Marge horizontale
                        child: Text(
                          'Titre',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Marge horizontale
                        child: Text(
                          'Nom Auteur',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: resultatsRecherche
                      .sublist(startIndex, endIndex)
                      .map((livre) {
                    return DataRow(cells: [
                      DataCell(
                        InkWell(
                          onTap: () => _ouvrirFicheLivre(livre),
                          child: _getHighlightedTextWidget(livre.titre),
                        ),
                      ),
                      DataCell(
                        _getHighlightedTextWidget(livre.nomAuteur),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            if (afficherMessagePasDeLivres)
              Center(
                child: Text('Pas de livres trouvés'),
              ),
            // Afficher la pagination en bas de l'écran
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bouton précédent
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      if (currentPage > 1) {
                        setState(() {
                          currentPage--;
                        });
                      }
                    },
                  ),

                  // Afficher le numéro de la page actuelle
                  Text('Page $currentPage / $totalPages'),

                  // Bouton suivant
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (currentPage < totalPages) {
                        setState(() {
                          currentPage++;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }

  String _getAppBarTitle() {
    int nombreLivresTrouves = resultatsRecherche.length;
    String critere = 'livres';
    if (critereRecherche == 'auteur') {
      critere = 'auteurs';
    } else if (critereRecherche == 'localisation') {
      critere = 'localisations';
    }
    return '$critere : $texteRecherche ($nombreLivresTrouves titres)';
  }
}
