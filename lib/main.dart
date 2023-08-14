import 'package:flutter/material.dart';
import 'package:flutter_studi/widgets/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // Configuration de la localisation françaises
      locale: const Locale("fr", "FR"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("fr", "FR"),
      ],
    debugShowCheckedModeBanner: false,
      title: 'Titre de l\'application',

      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: const HomeScreen(),
      
    );
  }
}




