import 'package:flutter/material.dart';

class animation extends ChangeNotifier{
  bool _value = false;

  String _type = 'A Topic';

  String get type => _type;

  bool get value => _value;

  // Method to toggle the boolean value
  void toggle() {
    _value = !_value;
    notifyListeners();
  }
  void setValue(bool newValue) {
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

}