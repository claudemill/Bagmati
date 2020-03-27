import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportPatient extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Report Covid Patient"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(
                  icon: ImageIcon(AssetImage("assets/images/MedReport.png"),size:30,),
                  text: "Provide the following details",
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

