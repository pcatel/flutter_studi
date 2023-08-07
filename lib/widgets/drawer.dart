import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'ecran4.dart';
import 'ecran5.dart';
import 'ecran6.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  Future<void> _launchAppOrBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return Container(
  
      child: Drawer(
      
      width: MediaQuery.of(context).size.width * 0.5,
      
        child: Container(
        
          color: Color.fromARGB(255, 60, 166, 227),
          child: Column(
          
            children: [
              // En-tête avec 20% de l'espace
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const DrawerHeader(
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
              ),
              // Liste des éléments ListTile avec 60% de l'espace
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(
                  children: [
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
                    Divider(
                      color: Colors.black,
                      thickness: 2,
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
                    Divider(
                      color: Colors.black,
                      thickness: 2,
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
                    Divider(
                      color: Colors.black,
                      thickness: 2,
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
                    Divider(
                      color: Colors.black,
                      thickness: 2,
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
                  ],
                ),
              ),
              // Ligne des réseaux sociaux avec 20% de l'espace
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser("https://www.facebook.com/");
                      },
                      child: Image.asset('assets/images/Reseaux/facebook.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser("https://www.instagram.com/");
                      },
                      child: Image.asset('assets/images/Reseaux/instagram.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser("https://www.tiktok.com/");
                      },
                      child: Image.asset('assets/images/Reseaux/tiktok.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser("https://www.linkedin.com/");
                      },
                      child: Image.asset('assets/images/Reseaux/linkedin.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
