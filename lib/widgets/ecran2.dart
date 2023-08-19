import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fiche.dart';
import 'livre.dart';
import 'button_navigation.dart';

class Ecran2 extends StatefulWidget {
  const Ecran2({Key? key}) : super(key: key);

  @override
  _Ecran2State createState() => _Ecran2State();
}

class _Ecran2State extends State<Ecran2> {
  List<dynamic> jsonData = [];
  List<String> genresList = [];

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
        genresList = _extractGenres(jsonData);
      });
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
    }
  }

  List<String> _extractGenres(List<dynamic> jsonData) {
    Set<String> genresSet = Set();
    for (var book in jsonData) {
      if (book.containsKey('Genre')) {
        genresSet.add(book['Genre']);
      }
    }
    return genresSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Genres'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 32.0,
                mainAxisSpacing: 32.0,
              ),
              itemCount: genresList.length,
              itemBuilder: (context, index) {
                String genre = genresList[index];
                int count =
                    jsonData.where((book) => book['Genre'] == genre).length;
                String imagePath =
                    'assets/images/Genres/${genre.toLowerCase()}.jpg';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FicheGenre(
                          nomGenre: genre,
                          livres: jsonData
                              .where((book) => book['Genre'] == genre)
                              .toList(),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              genre,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '($count titres)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
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

class FicheGenre extends StatefulWidget {
  final String nomGenre;
  final List<dynamic>? livres;

  const FicheGenre({required this.nomGenre, this.livres, Key? key})
      : super(key: key);

  @override
  _FicheGenreState createState() => _FicheGenreState();
}

class _FicheGenreState extends State<FicheGenre> {
  int livresPerPage = 12;
  int currentPage = 1;

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

  void _afficherFicheLivre(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FichePage(livre: livre)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> currentLivres = getCurrentPageLivres();

    return Scaffold(
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        //title: Text(widget.nomGenre),
        title:
            Text('${widget.nomGenre} (${widget.livres?.length ?? 0} titres)'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text('Nombre de livres pour ce genre : ${widget.livres?.length ?? 0}'),
            DataTable(
              columns: [
                DataColumn(label: Text('Titre')),
                DataColumn(label: Text('Auteur')),
                //DataColumn(label: Text('Année')),
              ],
              rows: currentLivres
                  .map(
                    (livre) => DataRow(
                      cells: [
                        DataCell(
                          InkWell(
                            onTap: () {
                              _afficherFicheLivre(Livre.fromJson(livre));
                            },
                            child: Text(livre['Titre'] ?? ''),
                          ),
                        ),
                        DataCell(Text(livre['Nom Auteur'] ?? '')),
                        // DataCell(Text(livre['Année'] ?? '')),
                      ],
                    ),
                  )
                  .toList(),
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
