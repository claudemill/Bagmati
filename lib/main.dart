// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//hello suman, this is to test comment
import 'dart:convert';
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

  Future finalCovidDataMap;
  Map covidMapCombined;
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
            body: Container(
              child: FutureBuilder(
                  future: finalCovidDataMap,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("none=========");
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Text("Active and waiting=========>>>");
                      case ConnectionState.done:
                        covidMapCombined = snapshot.data as Map;
                        // return Text("${covidMapCombined['localDataMap']?.toString()}");
                        return TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Cases: ${covidMapCombined['globalDataMap']['cases']}"),
                                    Text(
                                        "Deaths: ${covidMapCombined['globalDataMap']['deaths']}"),
                                    Text(
                                        "Recovered: ${covidMapCombined['globalDataMap']['recovered']}"),
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
                                    Text(
                                        "Active: ${covidMapCombined['localDataMap']['active']}"),
                                    Text(
                                        "Total Cases: ${covidMapCombined['localDataMap']['cases']}"),
                                    Text(
                                        "Cases Reported Today: ${covidMapCombined['localDataMap']['todayCases']}"),
                                    Text(
                                        "Recovered Cases: ${covidMapCombined['localDataMap']['recovered']}"),
                                    Text(
                                        "Critical Cases: ${covidMapCombined['localDataMap']['critical']}"),
                                    Text(
                                        "Total Deaths: ${covidMapCombined['localDataMap']['deaths']}"),
                                    Text(
                                        "Deaths Today: ${covidMapCombined['localDataMap']['todayDeaths']}"),
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
