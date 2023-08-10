import 'package:flutter/material.dart';
import 'livre.dart';
import 'dart:convert';
import 'dart:io';

class FichePage extends StatelessWidget {
  final Livre livre;

  const FichePage({required this.livre, Key? key}) : super(key: key);

  final double imageSize = 200; // Taille des images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color.fromARGB(255, 100, 198, 244),
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
                  Flexible(child: _buildImageContainer(context, livre.photo, 'photo')),
                  SizedBox(width: 16),
                  Flexible(child: _buildImageContainer(context, livre.resume.url, 'resume')),
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
              // Pret
            _buildRowWithColor(
              child: Row(
                    children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //_handleEdit(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
               onPressed: () {
          _showDeleteConfirmationDialog(context, livre); // Passer "livre" en paramètre
        },
                ),
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

  Widget _buildImageContainer(BuildContext context, String url, String type) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, url, type,),
      child: Container(
        width: imageSize,
        height: imageSize,
        child: Align(
          alignment: Alignment.center,
          child: url.isNotEmpty
              ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(url)}").toString())
              : Placeholder(),
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl, String type,) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(imageUrl: imageUrl, type: type,  titre: livre.titre),
      ),
    );
  }

  String _sanitizeString(String input) {
    return input.replaceAll(RegExp(r'[-\s]'), '');
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String type;
  final String titre;

  const FullScreenImagePage({required this.imageUrl, required this.type,  required this.titre, Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Color.fromARGB(255, 100, 198, 244),
    appBar: AppBar(
     title: Text(titre), 
      ),
    body: Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: type == 'photo'
                ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(imageUrl)}").toString())
                : type == 'resume'
                  ? Image.network(Uri.parse("https://www.pascalcatel.com/biblio/${_sanitizeString(imageUrl)}").toString())
                   : SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 16, // Ajustez la position verticale selon vos besoins
          right: 16, // Ajustez la position horizontale selon vos besoins
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        
      ],
    ),
  );
}


  String _sanitizeString(String input) {
    return input.replaceAll(RegExp(r'[-\s]'), '');
  }
}
_showDeleteConfirmationDialog(BuildContext context, Livre livre) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Supprimer le livre'),
        content: Text('Êtes-vous sûr de vouloir supprimer ce livre ?'),
        actions: [
          TextButton(
            child: Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Oui'),
            onPressed: () async {
             await _deleteBookAndSave(livre);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _deleteBookAndSave(Livre livre) async {
  final booksFilePath = 'data/livres.json';
  
  // Charger le contenu actuel du fichier JSON
  final file = File(booksFilePath);
  final content = await file.readAsString();
  final jsonData = json.decode(content) as List<dynamic>;

  // Supprimer le nœud du livre
  jsonData.removeWhere((book) => book['titre'] == livre.titre);

  // Écrire le contenu mis à jour dans le fichier JSON
  final updatedContent = json.encode(jsonData);
  await file.writeAsString(updatedContent);
}




