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

  dynamic maleOrFemale;

  @override
  void initState() {
    super.initState();
    // maleOrFemale="" ;
  }

  setMaleOrFemale(dynamic val) {
    setState(() {
      maleOrFemale = val;
    });
  }

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

// Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      PatientForm patientForm = PatientForm(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          addressController.text,
          maleOrFemale
          );

      PatientFormController patientFormController =
          PatientFormController((String response) {
        print("Response: $response");
        if (response == PatientFormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Patient Details Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Submitting Patient Details");

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
            title: Text("रिपोर्ट कोरोना बिरामी"),
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
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (!value.contains("@")) {
                                          return 'Enter Valid Email';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration:
                                          InputDecoration(labelText: 'E-mail'),
                                    ),
                                    TextFormField(
                                      controller: mobileNoController,
                                      validator: (value) {
                                        if (value.trim().length != 10) {
                                          return 'Enter 10 Digit Mobile Number';
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
                                    Text("लिङ्ग:"),
                                   RadioButtonGroup(
                                     orientation: GroupedButtonsOrientation.HORIZONTAL,
                                     labels: <String>[
                                      "पुरुष",
                                      "महिला"
                                   ],
                                   onSelected: (String selected){
                                     setMaleOrFemale(selected);
                                     debugPrint("selectd m or f====>${maleOrFemale}");
                                   },
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
                          onPressed: _submitForm,
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
