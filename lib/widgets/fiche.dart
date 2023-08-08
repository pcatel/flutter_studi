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
              subtitle: livre.resume.url.isNotEmpty
                  ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(livre.resume.url)}").toString())
                  : Text('Pas de résumé avec image'),
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
              subtitle: livre.photo.isNotEmpty
                  ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(livre.photo)}").toString())
                  : Text('Pas de photo disponible'),
            ),
          ],
        ),
      ),
    );
  }

  String _sanitizeString(String input) {
    return input.replaceAll(RegExp(r'[-\s]'), '');
  }
}
