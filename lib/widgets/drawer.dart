import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'ecran4.dart';
import 'ecran5.dart';

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
          color: Color(0xFF430C05),
          child: Column(
            children: [
              // En-tête avec 20% de l'espace
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFFD46F4D),
                  ),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFD46F4D)),
                    accountName: Row(
                      children: [
                        Text(
                          "Pascal CATEL",
                          style: TextStyle(
                              color: Color(0xFF00353F),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    accountEmail: Row(
                      children: [
                        Text(
                          "pcatel@pascalcatel.com",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF430C05),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    currentAccountPictureSize: Size.square(100),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/matete.png'),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              // Liste des éléments ListTile avec 60% de l'espace
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(vertical: -4), // to compact

                          leading: SizedBox(
                            width: 24,
                            height: 50,
                            child: Image.asset(
                              'assets/images/livres.png',
                              color: Color(0xFF08C5D1),
                            ),
                          ),
                          title: const Text(
                            "Livres",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFBF66),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Ecran1()),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(vertical: -4), // to compact
                          leading: SizedBox(
                            width: 24,
                            height: 50,
                            child: Image.asset('assets/images/genre.png',
                            color: Color(0xFF08C5D1)),
                          ),
                          title: const Text(
                            "Genres",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFBF66),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Ecran2()),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(vertical: -4), // to compact
                          leading: SizedBox(
                            width: 24,
                            height: 50,
                            child: Image.asset('assets/images/auteur.png',color: Color(0xFF08C5D1),),
                          ),
                          title: const Text(
                            "Auteurs",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFBF66),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Ecran3()),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(vertical: -4), // to compact
                          leading: SizedBox(
                            width: 24,
                            height: 50,
                            child:
                                Image.asset('assets/images/localisation.png',color: Color(0xFF08C5D1),),
                          ),
                          title: const Text(
                            "Localisations",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFBF66),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Ecran4()),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(vertical: -4), // to compact
                          leading: SizedBox(
                            width: 24,
                            height: 50,
                            child: Image.asset('assets/images/rechercher.png',color: Color(0xFF08C5D1),),
                          ),
                          title: const Text(
                            "Rechercher",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFBF66),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Ecran5()),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ],
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
