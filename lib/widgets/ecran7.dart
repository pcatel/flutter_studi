import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'button_navigation.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Ecran7(),
        '/edit': (context) => MonEcranDeModification(),
      },
    );
  }
}

class Ecran7 extends StatefulWidget {
  const Ecran7({Key? key}) : super(key: key);

  @override
  _Ecran7State createState() => _Ecran7State();
}

class _Ecran7State extends State<Ecran7> {
  bool _isFileLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadJsonFile();
  }

  Future<void> _loadJsonFile() async {
    String jsonFilePath = 'assets/data/livres.json';

    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String destinationDir = appDocDir.path;

      File destinationFile = File('$destinationDir/livres.json');

      if (!await destinationFile.exists()) {
        String jsonString = await rootBundle.loadString(jsonFilePath);
        await destinationFile.writeAsString(jsonString);
      }

      setState(() {
        _isFileLoaded = true;
      });
    } catch (e) {
      print('Erreur lors du chargement du fichier : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargement'),
      ),
      body: Center(
        child: _isFileLoaded
            ? ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit');
                },
                child: Text('Accéder à l\'édition du JSON'),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class MonEcranDeModification extends StatefulWidget {
  @override
  _MonEcranDeModificationState createState() => _MonEcranDeModificationState();
}

class _MonEcranDeModificationState extends State<MonEcranDeModification> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String destinationDir = appDocDir.path;
      File destinationFile = File('$destinationDir/livres.json');

      if (await destinationFile.exists()) {
        String jsonString = await destinationFile.readAsString();
        setState(() {
          jsonData = json.decode(jsonString) as List<dynamic>;
        });
      }
    } catch (e) {
      print('Erreur lors du chargement des données JSON : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construisez l'interface utilisateur pour la modification du JSON
    // Utilisez la liste "jsonData" pour afficher et modifier les données
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification JSON'),
      ),
      body: ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jsonData[index]['Titre']),
            // Ajoutez ici les widgets pour la modification et la suppression
          );
        },
      ),
      bottomNavigationBar: const BarreIcones(),
    );
  }
}
