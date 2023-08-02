import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ecran1 extends StatefulWidget {
  const Ecran1({Key? key}) : super(key: key);

  @override
  _Ecran1State createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  List<dynamic> jsonData = [];
  int rowsPerPage = 5;
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
      });
    } catch (e) {
      // Gérer les erreurs éventuelles
      print('Erreur lors du chargement des données : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les livres'),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text('Les livres'),
          rowsPerPage: rowsPerPage,
          columnSpacing: 16.0, // Espace entre les colonnes
          dataRowMinHeight: 56.0, // Hauteur minimale des lignes du tableau
          dataRowMaxHeight: 56.0, // Hauteur maximale des lignes du tableau
          headingRowHeight: 64.0, // Hauteur de la ligne d'en-tête
          horizontalMargin: 16.0, // Marge horizontale du contenu du tableau
          onPageChanged: (int newPage) {
            setState(() {
              currentPage = newPage;
            });
          },
          source: _DataSource(jsonData),
          columns: const [
            DataColumn(
              label: Text('Titre'),
            ),
            DataColumn(
              label: Text('Nom Auteur'),
            ),
          ],
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
  final List<dynamic> _jsonData;
  int _selectedRowCount = 0;

  _DataSource(this._jsonData);

  @override
  DataRow? getRow(int index) {
    if (index >= _jsonData.length) {
      // Retourne null lorsque l'index est en dehors des limites des données
      return null;
    }
    return DataRow(
      cells: [
        DataCell(Text(_jsonData[index]['Titre'])),
        DataCell(Text(_jsonData[index]['Nom Auteur'])),
      ],
    );
  }

  @override
  int get rowCount => _jsonData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedRowCount;
}
