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
      child: Container(
        color: Color.fromARGB(255, 60, 166, 227),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 53, 82),
              ),
              child: UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 3, 53, 82)),
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
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/livres.png'),
              ),
              title: const Text(' Les livres '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ecran1()),
                );
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/genre.png'),
              ),
              title: const Text(' Les genres '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran2()),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/auteur.png'),
              ),
              title: const Text(' Les auteurs '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran3()),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/localisation.png'),
              ),
              title: const Text(' Les localisations '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran4()),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/rechercher.png'),
              ),
              title: const Text(' Rechercher '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran5()),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                width: 48,
                height: 240,
                child: Image.asset('assets/images/administrer.png'),
              ),
              title: const Text('Gestion'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ecran6()),
                );
              },
            ),
              Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/facebook.png'),
                  Image.asset('assets/images/instagram.png'),
                  Image.asset('assets/images/tiktok.png'),
                  Image.asset('assets/images/linkedin.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
