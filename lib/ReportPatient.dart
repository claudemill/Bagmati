import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'Model/PatientForm.dart';
import 'controller/PatientFormController.dart';

class ReportPatient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportPatientState();
  }
}

class ReportPatientState extends State<ReportPatient> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  dynamic gender;
  String selfQuarantine;
  String dryAndContinuousCough;
  String tired;
  String soreThroat;
  String shortnessOfBreath;
  String bodyPain;
  String diarrhoea;
  String runnyNose;
  String vomitting;
  String cameFromOtherCountry;
  String contactWithInfected;
  String anyOtherComplication;
  String relationToPatient;
  String selfPatient;

  @override
  void initState() {
    super.initState();
    // gender="" ;
  }

  setFormValues(String field, dynamic val) {
    setState(() {
      switch (field) {
        case "gender":
          gender = val;
          break;
        case "selfQuarantine":
          selfQuarantine = val;
          break;

        case "dryAndContinuousCough":
          dryAndContinuousCough = val;
          break;

        case "tired":
          tired = val;
          break;

        case "soreThroat":
          soreThroat = val;
          break;

        case "shortnessOfBreath":
          shortnessOfBreath = val;
          break;

        case "bodyPain":
          bodyPain = val;
          break;

        case "diarrhoea":
          diarrhoea = val;
          break;

        case "runnyNose":
          runnyNose = val;
          break;

        case "vomitting":
          vomitting = val;
          break;

        case "runnyNose":
          runnyNose = val;
          break;

        case "cameFromOtherCountry":
          cameFromOtherCountry = val;
          break;

        case "relationToPatient":
          relationToPatient = val;
          break;

        case "selfPatient":
          selfPatient = val;
          break;

        case "contactWithInfected":
          contactWithInfected = val;
          break;
      }
      gender = val;
    });
  }

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController transitController = TextEditingController();
  TextEditingController flightController = TextEditingController();
  TextEditingController anyComplicationController = TextEditingController();
  TextEditingController relationController = TextEditingController();

// Method to Submit Feedback and save it in Google Sheets
  void _submitForm(BuildContext context) {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      PatientForm patientForm = PatientForm(
          nameController.text,
          ageController.text,
          mobileNoController.text,
          addressController.text,
          gender,
          tempController.text,
          selfQuarantine,
          dryAndContinuousCough,
          tired,
          soreThroat,
          shortnessOfBreath,
          bodyPain,
          diarrhoea,
          runnyNose,
          vomitting,
          cameFromOtherCountry,
          countryController.text,
          flightController.text,
          transitController.text,
          contactWithInfected,
          anyComplicationController.text,
          relationToPatient,
          selfPatient);

      PatientFormController patientFormController =
          PatientFormController((String response) {
        print("Response: $response");
        if (response == PatientFormController.STATUS_SUCCESS) {
          debugPrint("inside response success===========>>>>");
          // Feedback is saved succesfully in Google Sheets.
          // _showSnackbar("Patient Details Submitted");
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentTextStyle: TextStyle(
                    color: Colors.indigo
                  ),
                  title: Text('सुचना !!'),
                  content: const Text('तपाइँको विवरण पेश भएको छ। धन्यबाद !'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportPatient()));
                      },
                    ),
                  ],
                );
              });
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
     showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentTextStyle: TextStyle(
                    color: Colors.indigo
                  ),
                  title: Text('सुचना !!'),
                  content: const Text('कृपया प्रतिक्ष्या गर्नुहोस्, तपाइँको विवरण पेश हुँदै छ।'),
                  // actions: <Widget>[
                  //   FlatButton(
                  //     child: Text('Ok'),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ReportPatient()));
                  //     },
                  //   ),
                  // ],
                );
              });
      // _showSnackbar("Submitting Patient Details");

      // Submit 'feedbackForm' and save it in Google Sheets.
      patientFormController.submitForm(patientForm);
    }
  }

// Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void handleOnChanged() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("कोरोना बिरामी रिपोर्ट"),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(
                  icon: ImageIcon(
                    AssetImage("assets/images/MedReport.png"),
                    size: 30,
                  ),
                  text: "निम्न विवरणहरू प्रदान गर्नुहोस्",
                ),
              ],
            ),
          ),
          body: Container(
              color: Colors.cyan,
              child: TabBarView(children: [
                new Scaffold(
                  key: _scaffoldKey,
                  resizeToAvoidBottomPadding: false,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Form(
                            key: _formKey,
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Valid Name';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(labelText: 'नाम'),
                                    ),
                                    Text(" "),
                                    Text("लिङ्ग:"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["पुरुष", "महिला"],
                                      onSelected: (String selected) {
                                        gender = selected;
                                        //  setFormValues("gender",selected);
                                        debugPrint(
                                            "selectd m or f====>${gender}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    TextFormField(
                                      controller: ageController,
                                      validator: (value) {
                                        if (value.trim().length > 130) {
                                          return 'Enter Valid Age';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          InputDecoration(labelText: 'उमेर:'),
                                    ),
                                    TextFormField(
                                      controller: tempController,
                                      // validator: (value) {
                                      //   if (value.trim().length != 10) {
                                      //     return 'Enter 10 Digit Mobile Number';
                                      //   }
                                      //   return null;
                                      // },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'तापक्रम',
                                      ),
                                    ),
                                    Text(
                                        "के बिरामी  सेल्फ क्वारेन्टाइनमा बस्नुभएको छ ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["छ", "छैन"],
                                      onSelected: (String selected) {
                                        selfQuarantine = selected;
                                        //  setFormValues("selfQuarantine",selected);
                                        debugPrint(
                                            "selectd selfQuarantine====>${selfQuarantine}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("सुख्खा तथा लहरे खोकी लागेको छ ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["छ", "छैन"],
                                      onSelected: (String selected) {
                                        dryAndContinuousCough = selected;
                                        //  setFormValues("dryAndContinuousCough",selected);
                                        debugPrint(
                                            "selectd dryAndContinuousCough====>${dryAndContinuousCough}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("बिरामीलाई थकाई लाग्छ  कि लाग्दैन ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["लाग्छ", "लाग्दैन"],
                                      onSelected: (String selected) {
                                        tired = selected;
                                        //  setFormValues("tired",selected);
                                        debugPrint(
                                            "selectd tired====>${tired}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("घाँटी बसेको छ कि छैन ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["छ", "छैन"],
                                      onSelected: (String selected) {
                                        soreThroat = selected;
                                        //  setFormValues("soreThroat",selected);
                                        debugPrint(
                                            "selectd tired====>${soreThroat}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text(
                                        "आराम गर्दा पनि सास छोटो भएजस्तो हुन्छ कि हुँदैन ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["हुन्छ", "हुँदैन"],
                                      onSelected: (String selected) {
                                        shortnessOfBreath = selected;
                                        //  setFormValues("shortnessOfBreath",selected);
                                        debugPrint(
                                            "selectd shortnessOfBreath====>${shortnessOfBreath}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("जीउ दुख्छ  कि दुख्दैन?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["दुख्छ", "दुख्दैन"],
                                      onSelected: (String selected) {
                                        bodyPain = selected;
                                        //  setFormValues("bodyPain",selected);
                                        debugPrint(
                                            "selectd bodyPain====>${bodyPain}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("पखाला चलेको छ कि छैन?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["छ", "छैन"],
                                      onSelected: (String selected) {
                                        diarrhoea = selected;
                                        //  setFormValues("diarrhoea",selected);
                                        debugPrint(
                                            "selectd diarrhoea====>${diarrhoea}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("सिँगान बग्छ  कि बग्दैन ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["बग्छ", "बग्दैन"],
                                      onSelected: (String selected) {
                                        runnyNose = selected;
                                        //  setFormValues("runnyNose",selected);
                                        debugPrint(
                                            "selectd runnyNose====>${runnyNose}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("वाकवाकी लागेको छ कि छैन ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["छ", "छैन"],
                                      onSelected: (String selected) {
                                        vomitting = selected;
                                        //  setFormValues("vomitting",selected);
                                        debugPrint(
                                            "selectd vomitting====>${vomitting}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text("कुनै बाहिर देशबाट फर्किनुभएको हो ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["हो", "होइन"],
                                      onSelected: (String selected) {
                                        cameFromOtherCountry = selected;
                                        //  setFormValues("cameFromOtherCountry",selected);
                                        debugPrint(
                                            "selectd cameFromOtherCountry====>${cameFromOtherCountry}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    Text(
                                        "संक्रमणको आशंका भएको व्यक्तिको सम्पर्कमा जानुभएको थियो ?"),
                                    RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      labels: <String>["थिएँ", "थियींन"],
                                      onSelected: (String selected) {
                                        contactWithInfected = selected;
                                        //  setFormValues("contactWithInfected",selected);
                                        debugPrint(
                                            "selectd contactWithInfected====>${contactWithInfected}");
                                      },
                                    ),
                                    Divider(color: Colors.black),
                                    TextFormField(
                                      controller: countryController,
                                      validator: (value) {
                                        // if (value.trim().length == 10) {
                                        //   return 'Enter 10 Digit Mobile Number';
                                        // }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText:
                                            'कुन देशबाट फर्किनुभएको हो ?',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: flightController,
                                      validator: (value) {
                                        // if (value.trim().length == 10) {
                                        //   return 'Enter 10 Digit Mobile Number';
                                        // }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText:
                                            'कुन फ्लाइटबाट फर्किनुभएको हो ?',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: transitController,
                                      validator: (value) {
                                        // if (value.trim().length == 10) {
                                        //   return 'Enter 10 Digit Mobile Number';
                                        // }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText:
                                            'ट्रान्जिट कुन ठाउँमा भएको थियो ?',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: anyComplicationController,
                                      validator: (value) {
                                        // if (value.trim().length == 10) {
                                        //   return 'Enter 10 Digit Mobile Number';
                                        // }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText:
                                            'अरु कुनै स्वास्थ्य समस्या छ भने उल्लेख गर्नुहोस्।',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: mobileNoController,
                                      validator: (value) {
                                        if (value.trim().length != 10) {
                                          return '१० वटा अंक  भएको मोबाइल नम्बर लेख्नुहोस्।';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'मोबाइल नम्बर',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: addressController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Valid Address';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      decoration:
                                          InputDecoration(labelText: 'ठेगाना'),
                                    ),

                                    // CheckboxGroup(
                                    //   orientation: GroupedButtonsOrientation.VERTICAL,
                                    //     labels: <String>[
                                    //       "Sunday",
                                    //       "Monday",
                                    //       "Tuesday",
                                    //       "Wednesday",
                                    //       "Thursday",
                                    //       "Friday",
                                    //       "Saturday",
                                    //       "Sunday",
                                    //     ],
                                    //     onSelected: (List<String> checked) =>
                                    //         print(checked.toString())
                                    //         )
                                  ],
                                ),
                              ),
                            )),
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            _submitForm(context);
                          },
                          child: Text('बिरामी विवरण बुझाउनुहोस्'),
                        ),
                      ],
                    ),
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Card(
                //     color: Colors.blue,

                //   ),
                // ),
                //
              ])),
        ));
  }
}
