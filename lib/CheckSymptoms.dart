import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckSymptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Check Your Symptoms %"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(
                  icon: Icon(FontAwesomeIcons.stethoscope),
                  text: "Check Symptoms",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.question),
                  text: "Ask Questions",
                ),
                Tab(
                  icon: ImageIcon(AssetImage("assets/images/faq.png")),
                  text: "WHO FAQ",
                )
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Colors.white,
                              
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Colors.blue[100],
                              
                            ),
                          )
                        ])
          ),
        )
        );
  }
}
