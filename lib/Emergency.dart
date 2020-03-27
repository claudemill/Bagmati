import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Emergency extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("When At Emergency"),
      ),
      body: MaterialApp(
                color: Colors.cyan,

        home: Card(
          color:Colors.blue[200]
        ),
      ),
    );
  }




}

