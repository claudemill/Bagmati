import 'package:first/CheckSymptoms.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Emergency.dart';
import 'ReachUs.dart';
import 'ReportPatient.dart';

class SelfCheckAndReporting {
  final buttonsElevation = 10.0;
  List<Widget> getCheckAndReportOptions(BuildContext context) {
    List<Widget> returnList = [];
    var listView = Expanded(
        child: Center(
      child: SizedBox(
        height: 400,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: buttonsElevation,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.stethoscope,
                      color: Colors.cyan, size: 40),
                  title: Text("लक्षण जाँच गर्नुहोस्"),
                  subtitle: Text(
                      "\"तपाईंको लक्षणहरू मेल खाने प्रतिशतमा जान्न आफैलाई जाँच गर्नुहोस्\""),
                  trailing: Icon(FontAwesomeIcons.stethoscope,
                      color: Colors.cyan, size: 40),
                ),
                onPressed: () {
                  debugPrint("check symptoms clicked");
                  openSubPage(context, "checkSymptoms");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: buttonsElevation,
                child: ListTile(
                  leading: ImageIcon(AssetImage("assets/images/MedReport.png"),
                      color: Colors.cyan, size: 45),
                  title: Text("कोरोना बिरामीलाई रिपोर्ट गर्नुहोस्"),
                  subtitle: Text("\"यदि तपाइँको क्षेत्र मा कुनै पनि उपस्थित छ\""),
                  trailing: ImageIcon(AssetImage("assets/images/MedReport.png"),
                      color: Colors.cyan, size: 45),
                ),
                onPressed: () {
                  debugPrint("Report Covid clicked");
                  openSubPage(context, "reportPatient");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: buttonsElevation,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.ambulance,
                      color: Colors.cyan, size: 30),
                  title: Text("आपतकालीन आवस्थामा"),
                  subtitle: Text("\"आपतकालिन सम्पर्क र मार्गदर्शन खोज्नुहोस्\""),
                  trailing: Icon(FontAwesomeIcons.ambulance,
                      color: Colors.cyan, size: 30),
                ),
                onPressed: () {
                  debugPrint("emergency clicked");
                  openSubPage(context, "emergency");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: buttonsElevation,
                child: ListTile(
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.cyan,
                    size: 30,
                  ),
                  title: Text("हामीलाई सम्पर्क गर्नुहोस "),
                  subtitle: Text("तपाईं हामीलाई प्रतिक्रिया दिन सक्नुहुन्छ।"),
                  trailing: Icon(
                    Icons.contact_mail,
                    color: Colors.cyan,
                    size: 30,
                  ),
                ),
                onPressed: () {
                  debugPrint("reach us clicked");
                  openSubPage(context, "reachUs");
                },
              ),
            )
          ],
        ),
      ),
    )
    );
    returnList.add(listView);
    return returnList;
  }

  Future openSubPage(context, pageName) async {
    switch (pageName) {
      case 'checkSymptoms':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CheckSymptoms()));
        break;
      case 'reportPatient':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportPatient()));
        break;
      case 'emergency':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Emergency()));
        break;
      case 'reachUs':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReachUs()));

        break;
      default:
    }
  }
}
