import 'package:flutter/material.dart';
import 'livre.dart';
import 'button_navigation.dart';
import 'drawer.dart';

class FichePage extends StatelessWidget {
  final Livre livre;

  const FichePage({required this.livre, Key? key}) : super(key: key);

  final double imageSize = 250; // Taille des images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      backgroundColor: Color.fromARGB(255, 100, 198, 244),
      appBar: AppBar(
        title: Text(livre.titre),
         backgroundColor: Color(0xFF430C05),
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
                      color: const   Color(0xFFD46F4D),
                  
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              color: Color(0xFF00353F),
            ),
          ),
          Expanded(
            flex: 50,
            child: _buildRowWithColor(
              child: _buildImageContainerRow(context),
              color: Color(0xFFD46F4D),
            ),
          ),
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  SizedBox(width: 8),
                  Text(livre.genre,style: TextStyle(
                      color: const   Color(0xFF00353F),
                  
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ),),
                ],
              ),
              color: Color(0xFF08C5D1),
            ),
          ),
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Localisation:',style: TextStyle(
                      color: const   Color(0xFF00353F),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 8),
                  Text(livre.localisation,style: TextStyle(
                      color: const   Color(0xFF00353F),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 16),
                  Text('Rayon:',style: TextStyle(
                      color: const   Color(0xFF00353F),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 8),
                  Text(livre.rayon,style: TextStyle(
                      color: const   Color(0xFF00353F),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                ],
              ),
              color: Color(0xFFFFBF66),
            ),
          ),
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Commentaire:',style: TextStyle(
                      color: const   Color(0xFFFEFFFF),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 8),
                  Text(livre.commentaire,style: TextStyle(
                      color: const   Color(0xFFFEFFFF),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                ],
              ),
              color: Color(0xFFD46F4D),
            ),
          ),
          Expanded(
            flex: 10,
            child: _buildRowWithColor(
              child: Row(
                children: [
                  Text('Pret:',style: TextStyle(
                      color: const   Color(0xFFFEFFFF),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 8),
                  Text(livre.pret,style: TextStyle(
                      color: Color(0xFFFEFFFF),
                  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                ],
              ),
              color: Color(0xFF430C05),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarreIcones(),
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
      drawer: MyDrawerWidget(),
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
