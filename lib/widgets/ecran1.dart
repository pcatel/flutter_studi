import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fiche.dart'; // Importez la classe FichePage depuis le fichier fiche.dart
import 'livre.dart'; // Importez la classe Livre depuis le fichier livre.dart

class Ecran1 extends StatefulWidget {
  const Ecran1({Key? key}) : super(key: key);

  @override
  _Ecran1State createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  List<dynamic> jsonData = [];
  int rowsPerPage = 15;
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

  void _afficherFicheLivre(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FichePage(livre: livre)), // Afficher la page de la fiche du livre
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Les livres (${jsonData.length})'), // Afficher le nombre total de livres
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          //header: Text('Les livres'),

          rowsPerPage: rowsPerPage,
          availableRowsPerPage: [15, 25, 35],
          onRowsPerPageChanged: (int? value) {
            if (value != null) {
              setState(() {
                rowsPerPage = value;
              });
            }
          },
          columnSpacing: 16.0,
          dataRowMinHeight: 40.0,
          dataRowMaxHeight: 40.0,
          headingRowHeight: 64.0,
          horizontalMargin: 16.0,
          onPageChanged: (int newPage) {
            setState(() {
              currentPage = newPage;
            });
          },
          source: _DataSource(jsonData, rowsPerPage, currentPage,
              _afficherFicheLivre), // Passer la variable _afficherFicheLivre comme argument
          columns: const [
            DataColumn(
              label: Text(
                'Titre', // Modifier ici

                style: TextStyle(
                  fontSize: 16, // Taille du texte
                  color: Colors.blue, // Couleur du texte
                  fontWeight: FontWeight.bold, // Style de la police (gras)
                  // Ajoutez d'autres propriétés de style si nécessaire
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Nom Auteur',
                style: TextStyle(
                  fontSize: 16, // Taille du texte
                  color: Colors.blue, // Couleur du texte
                  fontWeight: FontWeight.bold, // Style de la police (gras)
                  // Ajoutez d'autres propriétés de style si nécessaire
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<dynamic> _jsonData;
  final int _rowsPerPage; // Ajouter la variable _rowsPerPage
  int _selectedRowCount = 0;
  final int currentPage;
  final Function(Livre) _afficherFicheLivre; // Ajouter cette variable

  _DataSource(this._jsonData, this._rowsPerPage, this.currentPage,
      this._afficherFicheLivre);

  @override
  DataRow? getRow(int index) {
    int realIndex =
        index + currentPage * _rowsPerPage; // Utiliser la variable _rowsPerPage
    if (realIndex >= _jsonData.length) {
      return null;
    }
    var livre =
        Livre.fromJson(_jsonData[realIndex]); // Convertir en objet Livre
    return DataRow(
      onSelectChanged: (bool? selected) {
        if (selected != null && selected) {
          _afficherFicheLivre(
              livre); // Afficher la fiche du livre lorsque l'on clique sur le titre
        }
      },
      cells: [
        DataCell(
          InkWell(
            // Ajouter InkWell ici pour rendre le titre cliquable
            onTap: () => _afficherFicheLivre(livre),
            child: Text(
              _jsonData[realIndex]['Titre'] ?? 'Titre manquant',
            ),
          ),
        ),
        DataCell(Text(_jsonData[realIndex]['Nom Auteur'] ?? 'Auteur manquant')),
      ],
    );
  }

  @override
  int get rowCount => _jsonData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedRowCount;

  @override
  void notifyListeners() {
    // Mettre à jour le nombre de livres pour l'auteur sélectionné
    String? selectedAuthor =
        _jsonData[currentPage * _rowsPerPage]['Nom Auteur'];
    _selectedRowCount =
        _jsonData.where((book) => book['Nom Auteur'] == selectedAuthor).length;
    super.notifyListeners();
  }
}
