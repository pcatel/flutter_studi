import 'package:flutter/material.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'ecran4.dart';
import 'ecran5.dart';
import 'ecran6.dart';

class BarreIcones extends StatefulWidget {
  const BarreIcones({Key? key}) : super(key: key);

  @override
  State<BarreIcones> createState() => _BarreIconesState();
}

class _BarreIconesState extends State<BarreIcones> {
  int _selectedIndex = 0;

  static const List<String> _images = [
    'assets/images/livres.png',
    'assets/images/genre.png',
    'assets/images/auteur.png',
    'assets/images/localisation.png',
    'assets/images/rechercher.png',
    'assets/images/administrer.png',
  ];

  static const List<String> _labels = [
    'Livres',
    'Genre',
    'Auteur',
    'Localisation',
    'Rechercher',
    'Administrer',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran1()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran2()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran3()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran4()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ecran5()),
        );
        break;
      case 5:
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
        color: const Color.fromARGB(255, 167, 202, 232), // Couleur de l'arrière-plan
        borderRadius: BorderRadius.circular(10), // Vous pouvez ajuster le rayon de bordure selon vos préférences
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 3, 53, 82),
        selectedItemColor: Colors.white, // Couleur de l'icône sélectionnée
        unselectedItemColor: Colors.grey, // Couleur des icônes non sélectionnées
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
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Couleur du texte du label sélectionné
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black, // Couleur du texte du label non sélectionné
        ),
      ),
    );
  }
}
