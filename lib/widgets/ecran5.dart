import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'fiche.dart'; // Importez la classe FichePage depuis le fichier fiche.dart
import 'livre.dart'; // Importez la classe Livre depuis le fichier livre.dart

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

  String _getAppBarTitle() {
    int nombreLivresTrouves = resultatsRecherche.length;
    String critere = 'livres';
    if (critereRecherche == 'auteur') {
      critere = 'auteurs';
    } else if (critereRecherche == 'localisation') {
      critere = 'localisations';
    }
    return '$critere ($nombreLivresTrouves ${critere} trouvés)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                ElevatedButton(
                  onPressed: () => _rechercher(),
                  child: Text('Rechercher'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: critereRecherche,
              onChanged: (value) => setState(() {
                critereRecherche = value!;
              }),
              items: [
                DropdownMenuItem(
                  value: 'livre',
                  child: Text('Titre'),
                ),
                DropdownMenuItem(
                  value: 'auteur',
                  child: Text('Nom Auteur'),
                ),
                DropdownMenuItem(
                  value: 'localisation',
                  child: Text('Localisation'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (resultatsRecherche.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Titre')),
                      DataColumn(label: Text('Nom Auteur')),
                      DataColumn(label: Text('Localisation')),
                    ],
                    rows: resultatsRecherche.map((livre) {
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
                        DataCell(
                          _getHighlightedTextWidget(livre.localisation),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            if (afficherMessagePasDeLivres)
              Center(
                child: Text('Pas de livres trouvés'),
              ),
          ],
        ),
      ),
    );
  }

  void _rechercher() {
    setState(() {
      if (critereRecherche == 'livre') {
        resultatsRecherche = livres
            .where((livre) => livre.titre.toLowerCase().contains(texteRecherche.toLowerCase()))
            .toList();
      } else if (critereRecherche == 'auteur') {
        resultatsRecherche = livres
            .where((livre) => livre.nomAuteur.toLowerCase().contains(texteRecherche.toLowerCase()))
            .toList();
      } else if (critereRecherche == 'localisation') {
        resultatsRecherche = livres
            .where((livre) => livre.localisation.toLowerCase().contains(texteRecherche.toLowerCase()))
            .toList();
      } else {
        resultatsRecherche = [];
      }

      afficherMessagePasDeLivres = (texteRecherche.isNotEmpty && resultatsRecherche.isEmpty);
    });
  }

  void _ouvrirFicheLivre(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FichePage(livre: livre)), // Afficher la page de la fiche du livre
    );
  }

  Widget _getHighlightedTextWidget(String text) {
    final highlightedText = texteRecherche.isNotEmpty && text.toLowerCase().contains(texteRecherche.toLowerCase())
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
}
