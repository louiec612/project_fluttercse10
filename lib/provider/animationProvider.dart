import 'package:flutter/material.dart';

class animation extends ChangeNotifier{
  bool _value = false;

  bool _tapped = false;
  bool get tapped => _tapped;

  String _type = 'A Topic';

  String get type => _type;

  bool get value => _value;

  // Method to toggle the boolean value
  void toggle() {
    _value = !_value;
    notifyListeners();
  }
  void setSwitchValue(bool newValue) {
    _value = newValue;
    notifyListeners();
  }

  void reverseValue(){
    _value = !_value;
    notifyListeners();
  }

  void setType(String text) {
    _type = text;
    notifyListeners();
  }

  void reversetapped(){
    _tapped = !_tapped;
    notifyListeners();
  }

}