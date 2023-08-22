import 'package:flutter/material.dart';
import 'drawer.dart';
import 'button_navigation.dart';
import 'ecranLivre.dart';
import 'ecranGenre.dart';
import 'ecranAuteur.dart';
import 'ecranLocalisation.dart';
import 'ecranRechercher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _images = [
    'assets/images/livres.png',
    'assets/images/genre.png',
    'assets/images/auteur.png',
    'assets/images/localisation.png',
    'assets/images/rechercher.png',
  ];

  final List<String> _labels = [
    'Livres',
    'Genre',
    'Auteur',
    'Localisation',
    'Rechercher',
  ];

  void _onIconTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranLivre()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranGenre()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranAuteur()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranLocalisation()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranRechercher()),
        );
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      backgroundColor: Color(0xFF08C5D1),
      appBar: AppBar(
        title: const Text("PCL Biblio"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: .00,
        backgroundColor: Color(0xFF430C05),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onIconTap(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _images[index],
                  height: 64,
                  width: 64,
                ),
                const SizedBox(height: 8),
                Text(
                  _labels[index],
                  style: const TextStyle(
                    color: Color.fromARGB(255, 3, 53, 82),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
