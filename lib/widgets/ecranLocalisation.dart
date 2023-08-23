import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ficheLivre.dart';
import 'livre.dart';
import 'button_navigation.dart';
import 'drawer.dart';

class EcranLocalisation extends StatefulWidget {
  const EcranLocalisation({Key? key}) : super(key: key);

  @override
  _EcranLocalisationState createState() => _EcranLocalisationState();
}

class _EcranLocalisationState extends State<EcranLocalisation> {
  List<dynamic> jsonData = [];
  List<String> localisationsList = [];

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
        localisationsList = _extractlocalisations(jsonData);
      });
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
    }
  }

  List<String> _extractlocalisations(List<dynamic> jsonData) {
    Set<String> localisationsSet = Set();
    for (var book in jsonData) {
      if (book.containsKey('localisation')) {
        localisationsSet.add(book['localisation']);
      }
    }
    return localisationsSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: const Text('Les localisations'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
              ),
              itemCount: localisationsList.length,
              itemBuilder: (context, index) {
                String localisation = localisationsList[index];
                int count = jsonData
                    .where((book) => book['localisation'] == localisation)
                    .length;
                String imagePath =
                    'assets/images/Localisations/${localisation.toLowerCase()}.jpg';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fichelocalisation(
                          nomlocalisation: localisation,
                          livres: jsonData
                              .where((book) =>
                                  book['localisation'] == localisation)
                              .toList(),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      color: Colors.black,
                      margin: EdgeInsets.all(25),
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Color.fromARGB(200, 67, 12, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      localisation,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(198, 255, 254, 254),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '($count titres)',
                                      style: TextStyle(
                                        color: Color(0xFFFFBF66),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}

class Fichelocalisation extends StatefulWidget {
  const Fichelocalisation(
      {required this.nomlocalisation, this.livres, Key? key})
      : super(key: key);

  final List<dynamic>? livres;
  final String nomlocalisation;

  @override
  _FichelocalisationState createState() => _FichelocalisationState();
}

class _FichelocalisationState extends State<Fichelocalisation> {
  int currentPage = 1;
  int livresPerPage = 12;

  List<dynamic> getCurrentPageLivres() {
    int startIndex = (currentPage - 1) * livresPerPage;
    int endIndex = startIndex + livresPerPage;
    return widget.livres!.sublist(startIndex,
        endIndex < widget.livres!.length ? endIndex : widget.livres!.length);
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  void nextPage() {
    int totalPages = (widget.livres!.length / livresPerPage).ceil();
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> currentLivres = getCurrentPageLivres();

    return Scaffold(
      //drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        //title: Text(widget.nomlocalisation),
        title: Text(
            '${widget.nomlocalisation} ( ${widget.livres?.length ?? 0} titres)'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text(
            // 'Nombre de livres pour cette localisation : ${widget.livres?.length ?? 0}'),
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
                ],
                rows: currentLivres
                    .map(
                      (livre) => DataRow(
                        cells: [
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FichePage(livre: Livre.fromJson(livre)),
                                  ),
                                );
                              },
                              child: Text(livre['Titre'] ?? ''),
                            ),
                          ),
                          DataCell(Text(livre['Nom Auteur'] ?? '')),
                          //DataCell(Text(livre['Année'] ?? '')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: previousPage,
                ),
                Text(
                  'Rows per page $livresPerPage ${currentPage * livresPerPage - livresPerPage + 1}-${currentPage * livresPerPage} of ${widget.livres!.length}',
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: nextPage,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}

// ... (autres parties du code)
