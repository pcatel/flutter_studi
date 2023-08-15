import 'package:flutter/material.dart';
import 'livre.dart';

class FichePage extends StatelessWidget {
  final Livre livre;

  const FichePage({required this.livre, Key? key}) : super(key: key);

  final double imageSize = 250; // Taille des images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 198, 244),
      appBar: AppBar(
        title: Text(livre.titre),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text('Auteur:'),
                  SizedBox(width: 8),
                  Text(
                    '${livre.prenomAuteur} ${livre.nomAuteur}',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 249, 249, 249),
                    
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              color: Color.fromARGB(255, 3, 53, 82),
            ),
          ),
          Expanded(
            flex: 50,
            child: _buildRowWithColor(
              child: _buildImageContainerRow(context),
              color: Color.fromARGB(255, 247, 248, 249),
            ),
          ),
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
              color: Color.fromARGB(255, 3, 53, 82),
            ),
          ),
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
              color: Color.fromARGB(255, 247, 248, 249),
            ),
          ),
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
              color: Color.fromARGB(255, 3, 53, 82),
            ),
          ),
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
              color: const Color.fromARGB(255, 255, 255, 254),
            ),
          ),
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

  Widget _buildImageContainerRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildImageContainer(context, livre.photo, 'photo'),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildImageContainer(context, livre.resume.url, 'resume'),
        ),
      ],
    );
  }

  Widget _buildImageContainer(BuildContext context, String url, String type) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, url, type),
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
            top: 16,
            right: 16,
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
