import 'package:flutter/cupertino.dart';

class PatientForm{
  String _name;
  String _age;
  String _mobileNo;
  String _address;
  String _gender;
  String _temp;
  String _selfQuarantine;
  String _dryAndContinuousCough;
  String _tired;
  String _soreThroat;
  String _shortnessOfBreath;
  String _bodyPain;
  String _diarrhoea;
  String _runnyNose;
  String _vomitting;
  String _cameFromOtherCountry;
  String _countryCameFrom;
  String _flightName;
  String _placeOfTransit;
  String _contactWithInfected;
  String _anyOtherComplication;
  String _relationToPatient;
  String _selfPatient;
  

  PatientForm(
  this._name,
  this._age,
  this._mobileNo,
  this._address,
  this._gender,
  this._temp,    
  this._selfQuarantine,  
  this._dryAndContinuousCough, 
  this._tired,  
  this._soreThroat,  
  this._shortnessOfBreath, 
  this._bodyPain, 
  this._diarrhoea, 
  this._runnyNose,  
  this._vomitting,  
  this._cameFromOtherCountry, 
  this._countryCameFrom, 
  this._flightName,  
  this._placeOfTransit,   
  this._contactWithInfected, 
  this._anyOtherComplication, 
  this._relationToPatient, 
  this._selfPatient, 
    );

  // Method to make GET parameters.
  String toParams() {
    debugPrint("addressssss=========${_address}");
        debugPrint("gender=========${_gender}");
     String requestString ="?name=$_name&age=$_age&mobileNo=$_mobileNo&address=$_address&gender=$_gender&temp=$_temp&selfQuarantine=$_selfQuarantine&dryAndContinuousCough=$_dryAndContinuousCough&tired=$_tired&soreThroat=$_soreThroat&shortnessOfBreath=$_shortnessOfBreath&bodyPain=$_bodyPain&diarrhoea=$_diarrhoea&runnyNose=$_runnyNose&vomitting=$_vomitting&cameFromOtherCountry=$_cameFromOtherCountry&countryCameFrom=$_countryCameFrom&flightName=$_flightName&placeOfTransit=$_placeOfTransit&contactWithInfected=$_contactWithInfected&anyOtherComplication=$_anyOtherComplication&relationToPatient=$_relationToPatient&selfPatient=$_selfPatient";
          // String requestString ="?name=$_name&age=$_age&mobileNo=$_mobileNo&address=$_address&temp=$_temp";

     
     
     debugPrint("requestString===>"+requestString);
     
     
     
     return requestString;
  } 
  
}