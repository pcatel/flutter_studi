import 'package:flutter/material.dart';
//import 'cellule_lettre.dart';
import 'drawer.dart';
import 'button_navigation.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Scaffold(
            drawer: const MyDrawerWidget(), // Utiliser le widget du Drawer ici

            backgroundColor: const Color.fromARGB(255, 54, 149, 196),
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
              elevation: 0.00,
              backgroundColor: const Color.fromARGB(255, 3, 53, 82),
            ), //AppBar

            body: const Column(children: [
             
            ]),
            bottomNavigationBar: const BarreIcones()));
  }
}
