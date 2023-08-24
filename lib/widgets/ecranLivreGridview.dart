import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ficheLivre.dart';
import 'livre.dart';
import 'button_navigation.dart';
import 'ecranLivre.dart';
import 'drawer.dart';

class EcranLivreGridview extends StatefulWidget {
  const EcranLivreGridview({Key? key}) : super(key: key);

  @override
  _EcranLivreGridviewState createState() => _EcranLivreGridviewState();
}

class _EcranLivreGridviewState extends State<EcranLivreGridview> {
  List<dynamic> jsonData = [];
  int currentPage = 0;
  int livresPerPage = 12; // Nombre de livres par page

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

  void _afficherFicheLivre(dynamic livre) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FichePage(livre: livre)),
    );
  }

  Future<String> _sanitizeString(String input) async {
    // Ajoutez ici la logique pour nettoyer l'URL si nécessaire
    return input.replaceAll(RegExp(r'[-\s]'), '');
  }

  int get itemsPerPage {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount =
        (screenWidth / 110).floor(); // Ajustez 110 selon vos besoins
    final int rowCount =
        (screenHeight / 110).floor(); // Ajustez 110 selon vos besoins
    return crossAxisCount * rowCount;
  }

  List<dynamic> get currentPageData {
    final int startIndex = currentPage * livresPerPage;
    final int endIndex =
        (currentPage + 1) * livresPerPage > jsonData.length
            ? jsonData.length
            : (currentPage + 1) * livresPerPage;
    return jsonData.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: Text('Les livres (${jsonData.length})'),
        backgroundColor: Color(0xFF430C05),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EcranLivre(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 110).floor(),
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.02,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                childAspectRatio: 0.90,
              ),
              itemCount: currentPageData.length,
              itemBuilder: (BuildContext context, int index) {
                var livreData = currentPageData[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Color(0xFF00353F),
                  child: InkWell(
                    onTap: () {
                      Livre livre = Livre.fromJson(livreData);
                      _afficherFicheLivre(livre);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<String>(
                          future: _sanitizeString(livreData['Photo']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Erreur : ${snapshot.error}');
                            } else {
                              String imageUrl = snapshot.data ?? '';
                              return Image.network(
                                Uri.parse(
                                  "https://www.pascalcatel.com/biblio/$imageUrl",
                                ).toString(),
                                width: 50,
                                height: 75,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
                          width: 100,
                        ),
                        Text(
                          livreData['Titre'] ?? 'Titre manquant',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 254, 254),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          livreData['Nom Auteur'] ?? 'Auteur manquant',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFBF66),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      if (currentPage > 0) {
                        currentPage--;
                      }
                    });
                  },
                ),
                Text(
                  '${currentPage * livresPerPage + 1}-${(currentPage + 1) * livresPerPage} of ${jsonData.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      if ((currentPage + 1) * livresPerPage < jsonData.length) {
                        currentPage++;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
