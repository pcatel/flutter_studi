import 'package:flutter/material.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'ecran4.dart';
import 'ecran5.dart';
import 'ecran6.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 3, 53, 82),
            ),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 3, 53, 82)),
              accountName: Text(
                "Pascal CATEL",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text("pcatel@pascalcatel.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/matete.png'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' Les livres '),
            onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ecran1()),
                );
              },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' Les genres '),
            onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran2()),
                );
              }
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Les auteurs '),
            onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran3()),
                );
              }
          ),
          ListTile(
            leading: const Icon(Icons.video_label),
            title: const Text(' Les localisations '),
            onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran4()),
                );
              }
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Rechercher '),
             onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran5()),
                );
              }
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('A propos'),
           onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran6()),
                );
              }
          ),
        ],
      ),
    );
  }
}
