import 'package:flutter/material.dart';
import 'livre.dart';

class FichePage extends StatelessWidget {
  final Livre livre;

  const FichePage({required this.livre, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livre.titre),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Titre'),
              subtitle: Text(livre.titre),
            ),
            ListTile(
              title: Text('Date de création'),
              subtitle: Text(livre.dateCreation),
            ),
            ListTile(
              title: Text('Auteur'),
              subtitle: Text('${livre.prenomAuteur} ${livre.nomAuteur}'),
            ),
            ListTile(
              title: Text('Résumé'),
              subtitle: Text(livre.resume),
            ),
            ListTile(
              title: Text('Genre'),
              subtitle: Text(livre.genre),
            ),
            ListTile(
              title: Text('Localisation'),
              subtitle: Text(livre.localisation),
            ),
            ListTile(
              title: Text('Rayon'),
              subtitle: Text(livre.rayon),
            ),
            ListTile(
              title: Text('Commentaire'),
              subtitle: Text(livre.commentaire),
            ),
            ListTile(
              title: Text('Pret'),
              subtitle: Text(livre.pret),
            ),
            ListTile(
              title: Text('Photo'),
              subtitle: Text(livre.photo), // Afficher le chemin de l'image comme du texte
            ),
          ],
        ),
      ),
    );
  }
}
