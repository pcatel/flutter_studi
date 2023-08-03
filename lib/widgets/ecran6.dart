import 'package:flutter/material.dart';

class Ecran6 extends StatelessWidget {
  const Ecran6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion'),
      ),
      body: const Center(
        child: Text('Gestion'),
      ),
    );
  }
}
