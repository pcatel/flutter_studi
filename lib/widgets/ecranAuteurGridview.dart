import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ficheLivre.dart';
import 'livre.dart';
import 'button_navigation.dart';
//import 'ecranAuteur.dart';
//import 'drawer.dart';

class EcranAuteurGridview extends StatefulWidget {
final String selectedAuteur;
   const EcranAuteurGridview({Key? key, required this.selectedAuteur}) : super(key: key);

  @override
  _EcranAuteurGridviewState createState() => _EcranAuteurGridviewState();
}

class _EcranAuteurGridviewState extends State<EcranAuteurGridview> {
  //List<dynamic> jsonData = [];
List<dynamic> jsonData = [];
  List<dynamic> filteredLivres = [];


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
        // Filtrer les livres correspondant à l'auteur sélectionné
        filteredLivres = jsonData.where((livreData) => livreData['Nom Auteur'] == widget.selectedAuteur).toList();
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
    // Calculer le nombre d'éléments par page en fonction de la taille de l'écran
    final int crossAxisCount =
        (screenWidth / 110).floor(); // Ajustez 150 selon vos besoins
    final int rowCount =
        (screenHeight / 110).floor(); // Ajustez 150 selon vos besoins
    return crossAxisCount * rowCount;
  }

  List<dynamic> get currentPageData {
    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = (currentPage + 1) * itemsPerPage;
    return jsonData.sublist(
        startIndex, endIndex > jsonData.length ? jsonData.length : endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (jsonData.length / itemsPerPage).ceil();

    return Scaffold(
      //drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
      
       

         title: Text('${widget.selectedAuteur} (${filteredLivres.length})'),
        backgroundColor: Color(0xFF430C05),
        actions: [
          IconButton(
            icon: Icon(Icons.list), // Icône pour ouvrir l'écran 1
            onPressed: () {
              Navigator.pop(context); // Revenir à l'écran précédent
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
              crossAxisCount: (MediaQuery.of(context).size.width / 110).floor(),
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.02,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
              childAspectRatio: 0.90,
            ),
       itemCount: filteredLivres.length,
              itemBuilder: (BuildContext context, int index) {
                var livreData = filteredLivres[index];

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
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                fontSize: 10),
          ),
          Text(
            livreData['Nom Auteur'] ?? 'Auteur manquant',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFFFBF66),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ],
      ),
    ),
  );
},

          )),
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
                'Page ${currentPage + 1} / $totalPages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
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