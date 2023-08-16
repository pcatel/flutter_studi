import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fiche.dart';
import 'livre.dart';
import 'button_navigation.dart';

class Ecran4 extends StatefulWidget {
  const Ecran4({Key? key}) : super(key: key);

  @override
  _Ecran4State createState() => _Ecran4State();
}

class _Ecran4State extends State<Ecran4> {
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



      // size of the screen


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
//var size = MediaQuery.of(context).size; 
  
/*24 is for notification bar on Android*/
//final double itemHeight = (size.height - kToolbarHeight - 24) / 2;


//final double itemWidth = size.width / 2;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Les localisations'),
        backgroundColor: Color(0xFF430C05),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          
            child: Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               
                  crossAxisCount: 2,
                 
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  
                ),

               
                itemCount: localisationsList.length,
                itemBuilder: (context, index) {
                  String localisation = localisationsList[index];
                  int count = jsonData
                      .where((book) => book['localisation'] == localisation)
                      .length;
                  String imagePath =
                      'assets/images/Localisations/${localisation.toLowerCase()}.jpg';

                  return Container(
                    child: InkWell(
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
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(),
                              image: DecorationImage(
                                image: AssetImage(
                                  imagePath,
                                
                               
                                
                                
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Color.fromARGB(200, 67, 12,
                                      5), // Utilisez une opacité plus élevée ici
                                  BlendMode
                                      .color, // Choisissez le mode de mélange approprié
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Fichelocalisation(
                                          nomlocalisation: localisation,
                                          livres: jsonData
                                              .where((book) =>
                                                  book['localisation'] ==
                                                  localisation)
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    localisation,
                                    style: TextStyle(
                                      backgroundColor: Color(0xFF430C05),
                                      color: Color.fromARGB(198, 255, 254, 254),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '($count titres)',
                                  style: TextStyle(
                                    backgroundColor: Color(0xFFD46F4D),
                                    color: Color(0xFF430C05),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}

class Fichelocalisation extends StatefulWidget {
  final String nomlocalisation;
  final List<dynamic>? livres;

  const Fichelocalisation(
      {required this.nomlocalisation, this.livres, Key? key})
      : super(key: key);

  @override
  _FichelocalisationState createState() => _FichelocalisationState();
}

class _FichelocalisationState extends State<Fichelocalisation> {
  int livresPerPage = 4;
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> currentLivres = getCurrentPageLivres();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomlocalisation),
        backgroundColor: Color(0xFF430C05),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                'Nombre de livres pour ce localisation : ${widget.livres?.length ?? 0}'),
            DataTable(
              columns: [
                DataColumn(label: Text('Titre')),
                DataColumn(label: Text('localisation')),
                DataColumn(label: Text('Année')),
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
                        DataCell(Text(livre['localisation'] ?? '')),
                        DataCell(Text(livre['Année'] ?? '')),
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
