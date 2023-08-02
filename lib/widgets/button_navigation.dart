import 'package:flutter/material.dart';

class BarreIcones extends StatefulWidget {
  const BarreIcones({Key? key}) : super(key: key);

  @override
  State<BarreIcones> createState() => _BarreIconesState();
}

class _BarreIconesState extends State<BarreIcones> {
  int _selectedIndex = 0;

  // Liste des icônes pour la navigation
  static const List<IconData> _icons = [
    Icons.category,
    Icons.search,
    Icons.add,
    Icons.favorite,
    Icons.search,
    Icons.book,
  
  ];

  // Méthode pour gérer le changement d'index de l'icône sélectionnée
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed, // Pour afficher toutes les icônes, même avec plus de 3 éléments
      items: _icons.map((IconData icon) {
        return BottomNavigationBarItem(
          icon: Icon(icon),
          label: '', // Vous pouvez laisser une chaîne vide si vous ne souhaitez pas afficher d'étiquette sous l'icône
        );
      }).toList(),
    );
  }
}
