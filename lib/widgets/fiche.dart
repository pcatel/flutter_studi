import 'package:flutter/material.dart';
import 'livre.dart';

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
      body: Column(
        children: [
          // Auteur
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Auteur:'),
                  SizedBox(width: 8),
                  Text('${livre.prenomAuteur} ${livre.nomAuteur}'),
                ],
              ),
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          // Photo et Résumé
          Expanded(
            flex: 50,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Expanded(
                    child: _buildImageContainer(context, livre.photo, 'photo'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildImageContainer(
                        context, livre.resume.url, 'resume'),
                  ),
                ],
              ),
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16),
          // Genre
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Genre:'),
                  SizedBox(width: 8),
                  Text(livre.genre),
                ],
              ),
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 16),
          // Localisation et Rayon
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
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
          ),
          SizedBox(height: 16),
          // Commentaire
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Commentaire:'),
                  SizedBox(width: 8),
                  Text(livre.commentaire),
                ],
              ),
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16),
          // Pret
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Pret:'),
                  SizedBox(width: 8),
                  Text(livre.pret),
                ],
              ),
              color: Colors.yellow,
            ),
          ),
          SizedBox(height: 16),
        ],
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
      onTap: () => _showFullScreenImage(
        context,
        url,
        type,
      ),
      child: Container(
        width: imageSize,
        height: imageSize,
        child: Align(
          alignment: Alignment.center,
          child: url.isNotEmpty
              ? Image.network(Uri.parse(
                      "https://www.pascalcatel.com/biblio/${_sanitizeString(url)}")
                  .toString())
              : Placeholder(),
        ),
      ),
    );
  }

  void _showFullScreenImage(
      BuildContext context, String imageUrl, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(
            imageUrl: imageUrl, type: type, titre: livre.titre),
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

  const FullScreenImagePage(
      {required this.imageUrl,
      required this.type,
      required this.titre,
      Key? key})
      : super(key: key);

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
                  ? Image.network(Uri.parse(
                          "https://www.pascalcatel.com/biblio/${_sanitizeString(imageUrl)}")
                      .toString())
                  : type == 'resume'
                      ? Image.network(Uri.parse(
                              "https://www.pascalcatel.com/biblio/${_sanitizeString(imageUrl)}")
                          .toString())
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
