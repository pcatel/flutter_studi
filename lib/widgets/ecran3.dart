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
  List<String> auteursList = [];
  int currentPage = 0;
  List<dynamic>? jsonData;

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
    List<dynamic>? livres =
        jsonData?.where((book) => book['Nom Auteur'] == nomAuteur).toList();
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
      backgroundColor: Color.fromRGBO(8, 197, 209, 1),
      appBar: AppBar(
        title: const Text('Les Auteurs'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              // header: Text('Les livres'),
              //arrowHeadColor: Color.fromARGB(66, 37, 13, 13),

              rowsPerPage: _DataSource.rowsPerPageDataSource,

              columns: [
                DataColumn(
                  label: Container(
                    width: 200,

                    padding: EdgeInsets.symmetric(
                        horizontal: 5), // Marge horizontale
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 5), // Marge horizontale
                    child: Text(
                      'Nbre',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //DataColumn(label: Text('Année')),
              ],

              source: _DataSource(auteursList, jsonData,
                  _afficherFicheAuteur), // Passer la méthode _afficherFicheAuteur ici
              //onPageChanged: (int newPage) {
              //  setState(() {
              //    currentPage = newPage;
              //  });
              //  },
              //  onRowsPerPageChanged: (int? value) {
              //  if (value != null) {
              //   setState(() {
              //     _DataSource.rowsPerPageDataSource = value;
              //    });
              //    }
              //  },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this._auteursList, this._jsonData,
      this._onRowTap); // Passer _onRowTap au constructeur

  static int rowsPerPageDataSource = 12;

  final List<String> _auteursList;
  int _currentPage = 0;
  final List<dynamic>? _jsonData;
  final Function(String) _onRowTap; // Ajouter la variable _onRowTap
  int _selectedRowCount = 0;

  @override
  DataRow? getRow(int index) {
    int realIndex = index + currentPage * rowsPerPageDataSource;
    if (_jsonData == null || realIndex >= _auteursList.length) {
      return null;
    }
    String nomAuteur = _auteursList[realIndex];
    int count =
        _jsonData!.where((book) => book['Nom Auteur'] == nomAuteur).length;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          GestureDetector(
            onTap: () {
              _onRowTap(
                  nomAuteur); // Utiliser la méthode _onRowTap passée au constructeur
            },
            child: Text(nomAuteur),
          ),
        ),
        DataCell(Text('$count')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _auteursList.length;

  @override
  int get selectedRowCount => _selectedRowCount;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    if (_currentPage == value) return;
    _currentPage = value;
    notifyListeners();
  }
}

class FicheAuteur extends StatelessWidget {
  const FicheAuteur({required this.nomAuteur, this.livres, Key? key})
      : super(key: key);

  final List<dynamic>? livres;
  final String nomAuteur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: Text(
            '${nomAuteur} (${livres?.length ?? 0} ${livres?.length == 1 ? 'titre' : 'titres'})'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text('Nombre de livres de l\'auteur : ${livres?.length ?? 0}'),
            //Text('${nomAuteur} ( ${livres?.length ?? 0} titres)'),
            if (livres != null)
              Container(
                width:
                    double.infinity, // Pour occuper toute la largeur de l'écran
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) =>
                      Color(0xFFD46F4D)), // Couleur de fond des titres

                  columns: [
                    DataColumn(
                      label: Container(
                        width: 200,

                        padding: EdgeInsets.symmetric(
                            horizontal: 5), // Marge horizontale
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 5), // Marge horizontale
                        child: Text(
                          'Genre',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    //DataColumn(label: Text('Année')),
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
                                      builder: (context) => FichePage(
                                          livre: Livre.fromJson(livre)),
                                    ),
                                  );
                                },
                                child: Text(livre['Titre'] ?? ''),
                              ),
                            ),
                            DataCell(Text(livre['Genre'] ?? '')),
                            // DataCell(Text(livre['Année'] ?? '')),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
