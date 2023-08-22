import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ficheLivre.dart';
import 'livre.dart';
import 'button_navigation.dart';
import 'ecranLivreGridview.dart';
import 'drawer.dart';


class Ecran1 extends StatefulWidget {
  const Ecran1({Key? key}) : super(key: key);

  @override
  _Ecran1State createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  List<dynamic> jsonData = [];
  int rowsPerPage = 12;
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
      MaterialPageRoute(builder: (context) => FichePage(livre: livre)),
    );
  }

  List<DataRow> _createRows(int startingIndex) {
    return List<DataRow>.generate(
      rowsPerPage,
      (index) {
        final dataIndex = startingIndex + index;
        if (dataIndex < jsonData.length) {
          var livre = Livre.fromJson(jsonData[dataIndex]);
          return DataRow(
            cells: [
              DataCell(
                InkWell(
                  onTap: () => _afficherFicheLivre(livre),
                  child: Text(
                    jsonData[dataIndex]['Titre'] ?? 'Titre manquant',
                  ),
                ),
              ),
              DataCell(
                Text(jsonData[dataIndex]['Nom Auteur'] ?? 'Auteur manquant'),
              ),
            ],
          );
        }
        return DataRow(cells: [DataCell(Text(''))]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final startingIndex = currentPage * rowsPerPage;

    return Scaffold(
     drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: Text('Les livres (${jsonData.length})'),
        backgroundColor: Color(0xFF430C05),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view_sharp), // Icône pour ouvrir l'écran 8
            onPressed: () {
              // Lorsque l'icône est appuyée, ouvrir l'écran 8
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ecran8()), // Remplacez Ecran8 par le nom correct de votre écran
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Color(0xFFD46F4D)),
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
                    width: 200,

                    padding: EdgeInsets.symmetric(
                        horizontal: 5), // Marge horizontale
                    child: Text(
                      'Auteur',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              rows: _createRows(startingIndex),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  if (currentPage > 0) {
                    setState(() {
                      currentPage--;
                    });
                  }
                },
              ),
              Text(
                'Page ${currentPage + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  final totalPages = (jsonData.length / rowsPerPage).ceil();
                  if (currentPage < totalPages - 1) {
                    setState(() {
                      currentPage++;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
