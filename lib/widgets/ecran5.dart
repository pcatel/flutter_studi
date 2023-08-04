import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Ecran5 extends StatefulWidget {
  const Ecran5({Key? key}) : super(key: key);

  @override
  _Ecran5State createState() => _Ecran5State();
}

class _Ecran5State extends State<Ecran5> {
  List<Map<String, dynamic>> livres = [];
  List<Map<String, dynamic>> resultatsRecherche = [];
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
      livres = jsonData.cast<Map<String, dynamic>>();
    });
  }

  void _rechercher() {
    setState(() {
      if (critereRecherche == 'livre') {
        resultatsRecherche = livres
            .where((livre) => (livre['Titre'] != null && livre['Titre'].toLowerCase().contains(texteRecherche.toLowerCase())))
            .toList();
      } else if (critereRecherche == 'auteur') {
        resultatsRecherche = livres
            .where((livre) => (livre['Nom Auteur'] != null && livre['Nom Auteur'].toLowerCase().contains(texteRecherche.toLowerCase())))
            .toList();
      } else if (critereRecherche == 'localisation') {
        resultatsRecherche = livres
            .where((livre) => (livre['localisation'] != null && livre['localisation'].toLowerCase().contains(texteRecherche.toLowerCase())))
            .toList();
      } else {
        resultatsRecherche = [];
      }

      afficherMessagePasDeLivres = (texteRecherche.isNotEmpty && resultatsRecherche.isEmpty);
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
                        DataCell(Text(livre['Titre'] ?? '')),
                        DataCell(Text(livre['Nom Auteur'] ?? '')),
                        DataCell(Text(livre['localisation'] ?? '')),
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
}
