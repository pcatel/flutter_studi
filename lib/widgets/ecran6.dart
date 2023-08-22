import 'package:flutter/material.dart';
import 'drawer.dart';

//import 'button_navigation.dart';
class Ecran6 extends StatelessWidget {
  const Ecran6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      appBar: AppBar(
        title: const Text('Gestion'),
      ),
      body: const Center(
        child: Text('Gestion'),
      ),
      //bottomNavigationBar: BottomAppBar(),
    );
  }
}
