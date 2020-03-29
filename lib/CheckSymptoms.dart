import 'dart:async';

import 'package:first/SymptomForm.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckSymptoms extends StatelessWidget {
  final Completer<WebViewController> _controller=  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Check Your Symptoms %"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              // isScrollable: true,
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
            child: Scaffold(
                          body: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                // color: Colors.blue,
                                child: SymptomForm(),
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
                                // color: Colors.blue[100],
                                child: Scaffold(
                                                                  body: WebView(
                                    initialUrl: "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses",
                                    javascriptMode: JavascriptMode.unrestricted,
                                    // onWebViewCreated:(WebViewController webViewcontroller ){
                                    //   _controller.complete(webViewcontroller);
                                    // },
                                  ),
                                ),
                              ),
                            )
                          ]),
                          floatingActionButton: FutureBuilder<WebViewController>(
                            future: _controller.future,
                            builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
                                // if(controller.hasData){
                                //   return FloatingActionButton(
                                //     child:Icon(Icons.alarm),
                                //     onPressed: (){
                                //       controller.data.loadUrl("https://youtube.com");
                                //     },
                                    
                                //   );
                                // }
                                return Container();
                            },
                                                      
                          ),
            )
          ),
        )
        );
  }
}
