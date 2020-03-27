import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Emergency extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("When You Are In An Emergency"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(
                  icon: Icon(FontAwesomeIcons.ambulance),
                  text: "Use the following information",
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.cyan,
            child: TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Colors.blue,
                            ),
                          ),
                          // 
                        ])
          ),
        )
        );
  }




}

