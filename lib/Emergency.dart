import 'package:first/Hospitals.dart';
import 'package:first/TestLabs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Services/CallsAndMessageService.dart';
import 'Services/ServiceLocator.dart';

class Emergency extends StatelessWidget {
  CallsAndMessagesService service = locator<CallsAndMessagesService>();

  returnTestLabsInfo() {
    TestLabs testLab = new TestLabs();
    List testLabList = testLab.getTestLabsList();
    List<Widget> testLabWidgets = [];
    for (var i = 0; i < testLabList.length; i++) {
      Widget widget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          elevation: 16,
          child: ListTile(
            // leading: Icon(FontAwesomeIcons.phone, color: Colors.green, size: 40),
            title:
                Text("${testLabList[i]['name']},${testLabList[i]['address']}",style:TextStyle(
                  color: Colors.teal
                ),),
            subtitle: Text("${testLabList[i]['phone']}",style:TextStyle(
              fontSize: 30,color: Colors.green,
            ),),
            trailing:
                Icon(FontAwesomeIcons.phone, color: Colors.green, size: 40),
          ),
          onPressed: () {
            debugPrint("check symptoms clicked==>>${testLabList[i]['phone']}");
            service.call("${testLabList[i]['phone']}");
          },
        ),
      );
      testLabWidgets.add(widget);
    }

    return Card(
      color: Colors.blue[200],
      child: ListView(
        children: testLabWidgets,
      ),
    );
  }

  returnHubHospitalsInfo() {
    Hospitals hospital = new Hospitals();
    List hospitalList = hospital.getHospitalList();
    List<Widget> hospitalWidgets = [];
    for (var i = 0; i < hospitalList.length; i++) {
      Widget widget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          elevation: 16,
          child: ListTile(
            // leading: Icon(FontAwesomeIcons.phone, color: Colors.green, size: 40),
            title: Text(
                "${hospitalList[i]['name']},${hospitalList[i]['address']}",textAlign: TextAlign.left,overflow:TextOverflow.fade,style:TextStyle(
              color: Colors.teal
            )),
            subtitle: Text("${hospitalList[i]['phone']}",style:TextStyle(
              fontSize: 30,color: Colors.green,
            )),
            trailing:
                Icon(FontAwesomeIcons.phone, color: Colors.green, size: 30),
          ),
          onPressed: () {
            debugPrint("check symptoms clicked==>>${hospitalList[i]['phone']}");
            service.call("${hospitalList[i]['phone']}");
          },
        ),
      );
      hospitalWidgets.add(widget);
    }

    return Card(
      color: Colors.blue[200],
      child: ListView(
        children: hospitalWidgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("When You Are In An Emergency"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(
                  icon: Icon(FontAwesomeIcons.hospitalSymbol),
                  text: "Hub Hospitals",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.medkit),
                  text: "Test Labs",
                ),
              ],
            ),
          ),
          body: Container(
              color: Colors.blue[200],
              child: TabBarView(
                  children: [returnHubHospitalsInfo(), returnTestLabsInfo()])),
        ));
  }
}
