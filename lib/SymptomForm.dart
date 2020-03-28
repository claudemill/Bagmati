import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SymptomForm extends StatefulWidget {
  @override
  SymptomFormState createState() => new SymptomFormState();
}

class SymptomFormState extends State<SymptomForm> {
  var currStep = 0;
  bool complete = false;
  next() {
    currStep + 1 != steps.length
        ? goTo(currStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    currStep= currStep!=0? currStep-1:0;
    // currStep + 1 != steps.length
    //     ? goTo(currStep + 1)
    //     : setState(() => complete = true);
  }

  goTo(int step) {
    setState(() => currStep = step);
  }

  final _formKey = GlobalKey<FormState>();
  List<Step> steps = [
    Step(
        title: Text("Name"),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
          ],
        )),
    Step(
        title: Text("Address"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
          ],
        )),
    Step(
        title: Text("Phone"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
          ],
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.cyan),
      home: new Scaffold(
          body: new Form(
        key: _formKey,
        child: Center(
          child: new Column(children: <Widget>[
            Expanded(
              child: new Stepper(
                steps: steps,
                type: StepperType.horizontal,
                currentStep: currStep,
                onStepContinue: next,
                // () {
                //   setState(() {
                //     if (currStep < steps.length - 1) {
                //       currStep = currStep + 1;
                //     } else {
                //       currStep = 0;
                //     }
                //   });
                // },
                onStepCancel: cancel,
                // () {
                //   setState(() {
                //     if (currStep > 0) {
                //       currStep = currStep - 1;
                //     } else {
                //       currStep = 0;
                //     }
                //   });
                // },
                onStepTapped: (step)=>goTo(step),
                // (step) {
                //   setState(() {
                //     currStep = step;
                //   });
                // },
              ),
            ),
            new RaisedButton(
              child: new Text(
                'Save details',
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              color: Colors.indigo,
            ),
          ]),
        ),
      )),
    );
  }
}
