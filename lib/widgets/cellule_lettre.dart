
import 'package:flutter/material.dart';

class CelluleLettre extends StatelessWidget {


//final Color couleurCellule = const Color(0xFF723C2F);
final Color couleurCellule;
final String lettre;
final String textOccures;




  const CelluleLettre({Key? key, required this.couleurCellule, required this.lettre, required this.textOccures}) : super(key: key);

  @override
  Widget build(BuildContext context) {

 return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      
      
      


      
      //color: Colors.red,
      //height: 50,
      //width: 200,
      decoration:  BoxDecoration(color: couleurCellule,
border: Border.all(
                    color: const Color.fromARGB(255, 1, 1, 1),
                    width: 1,
                  ),



      borderRadius: const BorderRadius.only (
     topLeft: Radius.circular(5.0),
 topRight: Radius.circular(5.0),
 bottomLeft: Radius.circular(20.0),
 bottomRight: Radius.circular(20.0),

     
      ),
   
      
      
      ), child: Row(children: [
      Text(" $lettre     :",
      style: const TextStyle(
      fontSize: 24.0,
      fontFamily: 'Pacifico',
      color: Colors.white
      ),
      ),
      
      
      Text(textOccures,
      style: const TextStyle(
      fontSize: 24.0,
      fontFamily: 'Pacifico',
      color: Colors.white
      ),
      )
      
      
      ],
      ),
      
      
      
      
      ),
    );
  }
}