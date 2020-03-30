import 'package:flutter/cupertino.dart';

class PatientForm{
  String _name;
  String _email;
  String _mobileNo;
  String _address;
  String _gender;

  PatientForm(
    this._name,
    this._email, 
    this._mobileNo,
    this._address,
    this._gender
    );

  // Method to make GET parameters.
  String toParams() {
    debugPrint("addressssss=========${_address}");
        debugPrint("gender=========${_gender}");
String requestString ="?name=$_name&email=$_email&mobileNo=$_mobileNo&address=$_address&gender=$_gender";
     debugPrint("requestString===>"+requestString);
     
     
     
     return requestString;
  } 
  
}