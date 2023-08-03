import 'package:flutter/material.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'ecran4.dart';
import 'ecran5.dart';
import 'ecran6.dart';


 // Importez l'écran que vous souhaitez ouvrir

class BarreIcones extends StatefulWidget {
  const BarreIcones({Key? key}) : super(key: key);

  @override
  State<BarreIcones> createState() => _BarreIconesState();
}

class _BarreIconesState extends State<BarreIcones> {
  int _selectedIndex = 0;

  // Liste des images pour la navigation
  static const List<String> _images = [
    'assets/images/livres.jpg',
    'assets/images/genre.jpg',
    'assets/images/auteur.jpg',
    'assets/images/localisation.jpg',
    'assets/images/rechercher.jpg',
    'assets/images/aPropos.jpg',
  ];

  // Méthode pour gérer le changement d'index de l'icône sélectionnée
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Effectuez la navigation vers l'écran correspondant ici
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
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: _images.map((String imagePath) {
        return BottomNavigationBarItem(
          icon: Image.asset(
            imagePath,
            height: 24,
            width: 24,
          ),
          label: '',
        );
      }).toList(),
    );
  }
}
