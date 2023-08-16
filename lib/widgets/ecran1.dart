import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fiche.dart';
import 'livre.dart';
import 'button_navigation.dart';

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
      String data = await rootBundle.loadString('data/livres.json');
      setState(() {
        jsonData = jsonDecode(data);
      });
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
    }
  }

  void _afficherFicheLivre(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FichePage(livre: livre)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les livres (${jsonData.length})'),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
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
              _afficherFicheLivre),
          columns: const [
            DataColumn(
              label: Text(
                'Titre',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Nom Auteur',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomAppBar(),
       bottomNavigationBar: const BarreIcones(),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<dynamic> _jsonData;
  final int _rowsPerPage;
  final int currentPage;
  final Function(Livre) _afficherFicheLivre;

  _DataSource(this._jsonData, this._rowsPerPage, this.currentPage,
      this._afficherFicheLivre);

  @override
  DataRow? getRow(int index) {
    int realIndex = index + currentPage * _rowsPerPage;
    if (realIndex >= _jsonData.length) {
      return null;
    }
    var livre = Livre.fromJson(_jsonData[realIndex]);
    return DataRow(
      cells: [
        DataCell(
          InkWell(
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
  int get selectedRowCount => 0; // Supprimer la gestion de la sélection
}
