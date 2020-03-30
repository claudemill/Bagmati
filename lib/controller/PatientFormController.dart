import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../Model/PatientForm.dart';

class PatientFormController {
  // Callback function to gyive response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbzNxfTvEd2MjNVVO8Vz0AbTRiwVRX9nkTEHez5tQSO5cIR03Fyo/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  PatientFormController(this.callback);

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(PatientForm patientForm) async {
    try {
      await http.get(
        URL + patientForm.toParams()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });    
    } catch (e) {
      print(e);
    }
  }
}