import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fiche.dart'; // Importez la classe FichePage depuis le fichier fiche.dart
import 'livre.dart'; // Importez la classe Livre depuis le fichier livre.dart
import 'button_navigation.dart';
class Ecran3 extends StatefulWidget {
  const Ecran3({Key? key}) : super(key: key);

  @override
  _Ecran3State createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  List<dynamic>? jsonData;
  List<String> auteursList = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _chargerDonnees();
  }

  Future<void> _chargerDonnees() async {
    try {
      String data = await rootBundle.loadString('data/livres.json');
      setState(() {
        jsonData = jsonDecode(data);
        auteursList = _extractAuteurs(jsonData!);
      });
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
    }
  }

  List<String> _extractAuteurs(List<dynamic> jsonData) {
    Set<String> auteursSet = Set();
    for (var book in jsonData) {
      if (book.containsKey('Nom Auteur')) {
        auteursSet.add(book['Nom Auteur']);
      }
    }
    List<String> auteursList = auteursSet.toList();
    auteursList.sort();
    return auteursList;
  }

  void _afficherFicheAuteur(String nomAuteur) {
    List<dynamic>? livres = jsonData?.where((book) => book['Nom Auteur'] == nomAuteur).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FicheAuteur(nomAuteur: nomAuteur, livres: livres),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Auteurs'),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text('Les livres'),
          rowsPerPage: _DataSource.rowsPerPageDataSource,
          availableRowsPerPage: [4, 8, 12], // Liste des valeurs disponibles pour rowsPerPage
          columns: const [
            DataColumn(label: Text('Auteur')),
            DataColumn(label: Text('Nbre de livre')),
          ],
          source: _DataSource(auteursList, jsonData, _afficherFicheAuteur), // Passer la méthode _afficherFicheAuteur ici
          onPageChanged: (int newPage) {
            setState(() {
              currentPage = newPage;
            });
          },
          onRowsPerPageChanged: (int? value) {
            if (value != null) {
              setState(() {
                _DataSource.rowsPerPageDataSource = value;
              });
            }
          },
        ),
      ),
     bottomNavigationBar: const BarreIcones(),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<String> _auteursList;
  final List<dynamic>? _jsonData;
  final Function(String) _onRowTap; // Ajouter la variable _onRowTap
  int _selectedRowCount = 0;

  _DataSource(this._auteursList, this._jsonData, this._onRowTap); // Passer _onRowTap au constructeur

  @override
  DataRow? getRow(int index) {
    int realIndex = index + currentPage * rowsPerPageDataSource;
    if (_jsonData == null || realIndex >= _auteursList.length) {
      return null;
    }
    String nomAuteur = _auteursList[realIndex];
    int count = _jsonData!.where((book) => book['Nom Auteur'] == nomAuteur).length;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          GestureDetector(
            onTap: () {
              _onRowTap(nomAuteur); // Utiliser la méthode _onRowTap passée au constructeur
            },
            child: Text(nomAuteur),
          ),
        ),
        DataCell(Text('$count')),
      ],
    );
  }

  @override
  int get rowCount => _auteursList.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedRowCount;

  int get currentPage => _currentPage;
  set currentPage(int value) {
    if (_currentPage == value) return;
    _currentPage = value;
    notifyListeners();
  }

  int _currentPage = 0;

  static int rowsPerPageDataSource = 4;
}

class FicheAuteur extends StatelessWidget {
  final String nomAuteur;
  final List<dynamic>? livres;

  const FicheAuteur({required this.nomAuteur, this.livres, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nomAuteur),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Nombre de livres de l\'auteur : ${livres?.length ?? 0}'),
            if (livres != null)
              DataTable(
                columns: [
                  DataColumn(label: Text('Titre')),
                  DataColumn(label: Text('Genre')),
                  DataColumn(label: Text('Année')),
                ],
                rows: livres!
                    .map(
                      (livre) => DataRow(
                        cells: [
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FichePage(livre: Livre.fromJson(livre)),
                                  ),
                                );
                              },
                              child: Text(livre['Titre'] ?? ''),
                            ),
                          ),
                          DataCell(Text(livre['Genre'] ?? '')),
                          DataCell(Text(livre['Année'] ?? '')),
                        ],
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
