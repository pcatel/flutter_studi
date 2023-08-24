import 'package:flutter/material.dart';
import 'package:flutter_studi/widgets/home_screen.dart';
import 'ecranLivre.dart';
import 'ecranGenre.dart';
import 'ecranAuteur.dart';
import 'ecranLocalisation.dart';
import 'ecranRechercher.dart';
import 'ecran6.dart';

class BarreIcones extends StatefulWidget {
  const BarreIcones({Key? key}) : super(key: key);

  @override
  State<BarreIcones> createState() => _BarreIconesState();
}

class _BarreIconesState extends State<BarreIcones> {
  int _selectedIndex = 0;

  static const List<String> _images = [
    'assets/images/accueil.png',
    'assets/images/livres.png',
    'assets/images/genre.png',
    'assets/images/auteur.png',
    'assets/images/localisation.png',
    'assets/images/rechercher.png',

  ];

  static const List<String> _labels = [
    'Accueil',
    'Livres',
    'Genre',
    'Auteur',
    'Localisation',
    'Rechercher',

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      
      
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranLivre()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranGenre()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranAuteur()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranLocalisation()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EcranRechercher()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran6()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFD46F4D), // Couleur de l'arrière-plan
        borderRadius: BorderRadius.circular(10), // Vous pouvez ajuster le rayon de bordure selon vos préférences
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFD46F4D),
        selectedItemColor: Colors.black, // Couleur de l'icône sélectionnée
        unselectedItemColor: Colors.white, // Couleur des icônes non sélectionnées
        items: _images.asMap().entries.map((entry) {
          int index = entry.key;
          String imagePath = entry.value;
          String label = _labels[index];
          return BottomNavigationBarItem(
            icon: Image.asset(
              imagePath,
              height: 36,
              width: 36,
            ),
            label: label,
          );
        }).toList(),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Couleur du texte du label sélectionné
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white, // Couleur du texte du label non sélectionné
        ),
      ),
    );
  }
}