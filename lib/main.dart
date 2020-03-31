// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'package:first/SelfCheckAndReporting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'Services/ServiceLocator.dart';

void main() {
  setupLocator();

  runApp(new TabsApp());
}

class TabsApp extends StatefulWidget {
  @override
  TabsAppState createState() => new TabsAppState();
}

class TabsAppState extends State<TabsApp> {
  // class TabsAppState extends State<TabsApp>  with AfterLayoutMixin<TabsApp>{

  Future finalCovidDataMap;
  Map covidMapCombined;
  SelfCheckAndReporting selfCheck = new SelfCheckAndReporting();
  @override
  void initState() {
    super.initState();
    finalCovidDataMap = fetchCovidData();
  }

  @override
  Widget build(BuildContext context) {
    print("after getting the covid data===in build=====>>>");
    print("this is the data in map====${finalCovidDataMap.toString()}");

    print("inside build----after cards--==========>>");

    print("this is the data in map====${finalCovidDataMap.toString()}");
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: const Text("Covid-19 Monitor"),
              ),
              backgroundColor: Colors.indigo[900],
              bottom: TabBar(
                isScrollable: true,
                tabs: <Tab>[
                  Tab(
                    icon: Icon(FontAwesomeIcons.globe),
                    text: "विश्वको तथ्यांक",
                  ),
                  Tab(
                    icon: ImageIcon(AssetImage(
                        "assets/images/nepalFlag.png")),
                    text: "नेपालको तथ्यांक",
                  ),
                  Tab(
                    icon: Icon(FontAwesomeIcons.firstAid),
                    text: "स्वोजाँच तथा रिपोर्ट",
                  )
                ],
              ),
            ),
            body: Container(
              child: FutureBuilder(
                  future: finalCovidDataMap,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("none=========");
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: Text("Loading Data..."));
                      case ConnectionState.done:
                        covidMapCombined = snapshot.data as Map;
                        // return Text("${covidMapCombined['localDataMap']?.toString()}");
                        return TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/globedecoration.webp"),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.white,
                                        child: Text(
                                          "संक्रमित: ${covidMapCombined['globalDataMap']['cases']}",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.lightBlue[00],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.white,
                                        child: Text(
                                          "मृत्यु:    ${covidMapCombined['globalDataMap']['deaths']}",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.white,
                                        child: Text(
                                          "निको भएका:         ${covidMapCombined['globalDataMap']['recovered']}",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.green[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/nepaldecoration.png"),
                                      fit: BoxFit.fitWidth)),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'हाल बिरामीहरु: ${covidMapCombined['localDataMap']['active']}',
                                      style: TextStyle(
                                        color: Colors.blueGrey[700],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'संक्रमित: ${covidMapCombined['localDataMap']['cases']}',
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'कुल जाँच गरिएका: ${covidMapCombined['localTestedInfoMap']['tested_total']}',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'आज रिपोर्ट भएका: ${covidMapCombined['localDataMap']['todayCases']}',
                                      style: TextStyle(
                                        color: Colors.deepPurple[900],
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'नाजुक मामलाहरु: ${covidMapCombined['localDataMap']['critical']}',
                                      style: TextStyle(
                                        color: Colors.brown[900],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'कुल मृत्यु: ${covidMapCombined['localDataMap']['deaths']}',
                                      style: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'आज मृत्यु भएका: ${covidMapCombined['localDataMap']['todayDeaths']}',
                                      style: TextStyle(
                                        color: Colors.lightBlue[900],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'निको भएका: ${covidMapCombined['localDataMap']['recovered']}',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Text(
                                    //     "Cases Per Million: ${covidMapCombined['localDataMap']['casesPerOneMillion']}"),
                                    // Text(
                                    //     "Deaths Per Million: ${covidMapCombined['localDataMap']['deathsPerOneMillion']}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/reportingDecoration.jpeg"),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: selfCheck
                                      .getCheckAndReportOptions(context),
                                ),
                              ),
                            ),
                          )
                        ]);
                      default:
                        return Center(child: Text("loading.."));
                    }
                  }),
            )

            //
            ),
      ),
    );
  }

  //   getCovidData() async {
  //   print("inside getFinalCovidData=======");
  //   finalCovidDataMap = await fetchCovidData();
  // }

  Future<Map> fetchCovidData() async {
    Map dataMap = new Map();
    print("hello hello hello===inside fetchCovidData===>>>");
    http.Response localResponse =
        await http.get('https://corona.lmao.ninja/countries/nepal');
    http.Response globalResponse =
        await http.get('https://corona.lmao.ninja/all');
    http.Response localTestedInfoResponse =
        await http.get('https://nepalcorona.info/api/v1/data/nepal');

    if (localResponse.statusCode == 200 && globalResponse.statusCode == 200 && localTestedInfoResponse.statusCode == 200) {
      Map localDataMap = json.decode(localResponse.body);
      Map globalDataMap = json.decode(globalResponse.body);
      Map localTestedInfoMap = json.decode(localTestedInfoResponse.body);


      // debugPrint("localResponse=====>>" + localResponse.body.toString());
      // debugPrint("globalResponse======>>" + globalResponse.body.toString());
      dataMap['localDataMap'] = localDataMap;
      dataMap["globalDataMap"] = globalDataMap;
      dataMap["localTestedInfoMap"] = localTestedInfoMap;

      // print("success to load covid data======>>>" + dataMap.toString());
      // If the server  returns a 200 OK response,
      // then parse the JSON.
      return dataMap;
    } else {
      debugPrint("failed to load covid data======>>>");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load covid data');
    }
  }
}
