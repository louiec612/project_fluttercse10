import 'package:flutter/material.dart';

class animation extends ChangeNotifier{
  bool _value = false;

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

}