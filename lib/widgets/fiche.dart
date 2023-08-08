import 'package:flutter/material.dart';
import 'livre.dart';

class FichePage extends StatelessWidget {
  final Livre livre;

  const FichePage({required this.livre, Key? key}) : super(key: key);

  final double imageSize = 100; // Taille des images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livre.titre),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            // Auteur
            _buildRowWithColor(
              child: Row(
                children: [
                  Text('Auteur:'),
                  SizedBox(width: 8),
                  Text('${livre.prenomAuteur} ${livre.nomAuteur}'),
                ],
              ),
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            // Photo et Résumé
            _buildRowWithColor(
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(child: _buildImageContainer(livre.photo)),
                  SizedBox(width: 16),
                  Flexible(child: _buildImageContainer(livre.resume.url)),
                ],
              ),
              color: Colors.green,
            ),
            SizedBox(height: 16),
            // Genre
            _buildRowWithColor(
              child: Row(
                children: [
                  Text('Genre:'),
                  SizedBox(width: 8),
                  Text(livre.genre),
                ],
              ),
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            // Localisation et Rayon
            _buildRowWithColor(
              child: Row(
                children: [
                  Text('Localisation:'),
                  SizedBox(width: 8),
                  Text(livre.localisation),
                  SizedBox(width: 16),
                  Text('Rayon:'),
                  SizedBox(width: 8),
                  Text(livre.rayon),
                ],
              ),
              color: Colors.purple,
            ),
            SizedBox(height: 16),
            // Commentaire
            _buildRowWithColor(
              child: Row(
                children: [
                  Text('Commentaire:'),
                  SizedBox(width: 8),
                  Text(livre.commentaire),
                ],
              ),
              color: Colors.red,
            ),
            SizedBox(height: 16),
            // Pret
            _buildRowWithColor(
              child: Row(
                children: [
                  Text('Pret:'),
                  SizedBox(width: 8),
                  Text(livre.pret),
                ],
              ),
              color: Colors.yellow,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithColor({required Widget child, required Color color}) {
    return Container(
      color: color,
      padding: EdgeInsets.all(8),
      child: child,
    );
  }

  Widget _buildImageContainer(String url) {
    return Container(
      width: imageSize,
      height: imageSize,
      child: Align(
        alignment: Alignment.center,
        child: url.isNotEmpty
            ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(url)}").toString())
            : Placeholder(), // Utilisation d'un Placeholder en cas d'absence d'image
      ),
    );
  }

  String _sanitizeString(String input) {
    return input.replaceAll(RegExp(r'[-\s]'), '');
  }
}
