import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ficheLivre.dart';
import 'livre.dart';
import 'button_navigation.dart';
import 'drawer.dart';
import 'ecranGenreGridview.dart';

class EcranGenre extends StatefulWidget {
  const EcranGenre({Key? key}) : super(key: key);

  @override
  _EcranGenreState createState() => _EcranGenreState();
}

class _EcranGenreState extends State<EcranGenre> {
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
      drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: const Text('Les Genres'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //crossAxisSpacing: 32.0,
               // mainAxisSpacing: 32.0,
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
                         alignment: Alignment.center,
                          ),
                        ),
                       
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,

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
      //drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title:
            Text('${widget.nomGenre} (${widget.livres?.length ?? 0} titres)'),
        backgroundColor: Color(0xFF430C05),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EcranGenreGridview(selectedGenre: widget.nomGenre)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xFFD46F4D)),
                columns: [
                  DataColumn(
                    label: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                rows: currentLivres
                    .map(
                      (livre) => DataRow(
                        cells: [
                          DataCell(
                            InkWell(
                              onTap: () {
                                _afficherFicheLivre(Livre.fromJson(livre));
                              },
                              child: Text(
                                livre['Titre'] ?? '',
                              ),
                            ),
                          ),
                          DataCell(Text(livre['Nom Auteur'] ?? '')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            if (widget.livres!.length > livresPerPage)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: previousPage,
                  ),
                  Text(
                    '${currentPage * livresPerPage - livresPerPage + 1}-${currentPage * livresPerPage} of ${widget.livres!.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
