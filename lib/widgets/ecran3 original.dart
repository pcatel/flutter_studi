import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ecran3 extends StatefulWidget {
  const Ecran3({Key? key}) : super(key: key);

  @override
  _Ecran3State createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  List<dynamic> jsonData = [];
  List<String> auteursList = [];
  int currentPage = 0;

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
        auteursList = _extractAuteurs(jsonData);
      });
    } catch (e) {
      // Gérer les erreurs éventuelles
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
          availableRowsPerPage: [4, 8, 15], // Liste des valeurs disponibles pour rowsPerPage
          columns: const [
            DataColumn(label: Text('Auteur')),
            DataColumn(label: Text('Nbre de livre')),
          ],
          source: _DataSource(auteursList, jsonData),
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Nombre de tableaux disponibles : ${jsonData.length}'),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<String> _auteursList;
  final List<dynamic> _jsonData;
  int _selectedRowCount = 0;

  _DataSource(this._auteursList, this._jsonData);

  @override
  DataRow? getRow(int index) {
    int realIndex = index + currentPage * rowsPerPageDataSource;
    if (realIndex >= _jsonData.length) {
      return null;
    }
    String auteur = _auteursList[realIndex];
    int count = _jsonData.where((book) => book['Nom Auteur'] == auteur).length;
    return DataRow(
      cells: [
        DataCell(Text(auteur)),
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
