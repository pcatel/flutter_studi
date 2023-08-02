import 'package:flutter/material.dart';

class Ecran5 extends StatelessWidget {
  const Ecran5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher'),
      ),
      body: const Center(
        child: Text('Rechercher'),
      ),
    );
  }
}
