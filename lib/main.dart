// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class CovidAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Covid-19 Tracker'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((CovidData choice) {
                return Tab(
                  text: choice.title,
                  icon: choice.icon,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((CovidData choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ChoiceCard(
                  
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CovidData {
  CovidData({this.title, this.icon,this.cases,this.todayCases,
  this.todayDeaths,this.recovered,this.active,this.critical,this.casesPerOneMillion,this.deathsPerOneMillion});

   String title;
   dynamic icon;
  final String cases;
  final String todayCases;
  final String todayDeaths;
  final String recovered;
  final String active;
  final String critical;
  final String casesPerOneMillion;
  final String deathsPerOneMillion;

  CovidData.fromJson(Map<String, dynamic> json)
      : cases = json['cases'],
        todayCases = json['todayCases'],
        todayDeaths = json['todayDeaths'],
        recovered = json['recovered'],
        active = json['active'],
        critical = json['critical'],
        casesPerOneMillion = json['casesPerOneMillion'],
        deathsPerOneMillion = json['deathsPerOneMillion']
        ;

  Map<String, dynamic> toJson() =>
    {
      'cases': cases,
      'todayCases': todayCases,
      'todayDeaths':todayDeaths,
      'recovered':recovered,
      'active':active,
      'critical':critical,
      'casesPerOneMillion':casesPerOneMillion,
      'deathsPerOneMillion':deathsPerOneMillion
    };

}

 fetchCovidData() async {
  final response = await http.get('https://corona.lmao.ninja/countries/nepal');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CovidData.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load covid data');
  }
}


   List<CovidData> choices =  [
   CovidData(title: 'Global Data', icon: Icon(FontAwesomeIcons.globe)),
   CovidData(
     title: 'Nepal Data', 
   icon:ImageIcon(NetworkImage("https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/np.png")),
   ),
   CovidData(title: 'Questions', icon: Icon(FontAwesomeIcons.question)),
 
   ];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final CovidData choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
           children:[
             Text("Data Here!"),
             //fetchCovidData(),
            // Text(choice.title, style: textStyle),
            // choice.icon
          ],

        ),
      ),
    );
  }
}

 fetchNepalData() {
  print("hello hello=========");
  Future <http.Response> covidData = http.get('https://corona.lmao.ninja/countries/nepal');
  print(covidData);
  Map covidDataMap= jsonDecode(covidData.toString());
  var data=CovidData.fromJson(covidDataMap);
  print('Hello this is recovered data=====>, ${data.recovered}');
  return data;
}

void main() {
  runApp(CovidAppBar());
  print(fetchNepalData());
}
