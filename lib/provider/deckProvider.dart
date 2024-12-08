import 'package:flutter/material.dart';

class deckProvider with ChangeNotifier {
  String _selectedValue = 'Option 1'; // Default selected value
  String get selectedValue => _selectedValue;

  // Method to update the selected value and notify listeners
  void updateSelectedValue(String newValue) {
    _selectedValue = newValue;
    print(newValue);
    notifyListeners();
  }

}