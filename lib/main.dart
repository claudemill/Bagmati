// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//hello suman, this is to test comment
import 'dart:convert';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(new TabsApp());

class TabsApp extends StatefulWidget {
  
  @override
  TabsAppState createState() => new TabsAppState();
}

class TabsAppState extends State<TabsApp> {
  // class TabsAppState extends State<TabsApp>  with AfterLayoutMixin<TabsApp>{

  static Map finalCovidDataMap = new Map();
  @override
  void initState() {
    super.initState();
      getCovidData();
  }

  @override
  Widget build(BuildContext context) {
   List<Widget> containers = [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //     "Cases: ${TabsAppState.finalCovidDataMap['globalDataMap']['cases']}"),
                  // Text(
                  //     "Deaths: ${TabsAppState.finalCovidDataMap['globalDataMap']['deaths']}"),
                  // Text(
                  //     "Recovered: ${TabsAppState.finalCovidDataMap['globalDataMap']['recovered']}"),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //     "Active: ${TabsAppState.finalCovidDataMap['localDataMap']['active']}"),
                  // Text(
                  //     "Total Cases: ${TabsAppState.finalCovidDataMap['localDataMap']['cases']}"),
                  // Text(
                  //     "Cases Reported Today: ${TabsAppState.finalCovidDataMap['localDataMap']['todayCases']}"),
                  // Text(
                  //     "Recovered Cases: ${TabsAppState.finalCovidDataMap['localDataMap']['recovered']}"),
                  // Text(
                  //     "Critical Cases: ${TabsAppState.finalCovidDataMap['localDataMap']['critical']}"),
                  // Text(
                  //     "Total Deaths: ${TabsAppState.finalCovidDataMap['localDataMap']['deaths']}"),
                  // Text(
                  //     "Deaths Today: ${TabsAppState.finalCovidDataMap['localDataMap']['todayDeaths']}"),
                  // Text(
                  //     "Cases Per Million: ${TabsAppState.finalCovidDataMap['localDataMap']['casesPerOneMillion']}"),
                  // Text(
                  //     "Deaths Per Million: ${TabsAppState.finalCovidDataMap['localDataMap']['deathsPerOneMillion']}"),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ),
        )
      ];

      print("after getting the covid data===in build=====>>>");
      print("this is the data in map====${finalCovidDataMap.toString()}");

      print("inside build----after cards--==========>>");

      print("this is the data in map====${finalCovidDataMap.toString()}");
      return new MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Covid-19 Monitor"),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Tab>[
                  Tab(
                    icon: Icon(FontAwesomeIcons.globe),
                    text: "Global Data",
                  ),
                  Tab(
                    icon: ImageIcon(NetworkImage(
                        "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/np.png")),
                    text: "Nepal's Data",
                  ),
                  Tab(
                    icon: Icon(FontAwesomeIcons.question),
                    text: "Questions",
                  )
                ],
              ),
            ),
            body: TabBarView(children: containers),
          ),
        ),
      );
  }

    getCovidData() async {
    print("inside getFinalCovidData=======");
    finalCovidDataMap = await fetchCovidData();
  }

  Future<Map> fetchCovidData() async {
    Map dataMap = new Map();
    print("hello hello hello===inside fetchCovidData===>>>");
    http.Response localResponse =
        await http.get('https://corona.lmao.ninja/countries/nepal');
    http.Response globalResponse =
        await http.get('https://corona.lmao.ninja/all');

    if (localResponse.statusCode == 200 && globalResponse.statusCode == 200) {
      Map localDataMap = json.decode(localResponse.body);
      Map globalDataMap = json.decode(globalResponse.body);

      debugPrint("localResponse=====>>" + localResponse.body.toString());
      debugPrint("globalResponse======>>" + globalResponse.body.toString());
      dataMap['localDataMap'] = localDataMap;
      dataMap["globalDataMap"] = globalDataMap;
      print("success to load covid data======>>>" + dataMap.toString());
      // If the server  returns a 200 OK response,
      // then parse the JSON.
      return dataMap;
    } else {
      print("failed to load covid data======>>>");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load covid data');
    
  
    }
}
}