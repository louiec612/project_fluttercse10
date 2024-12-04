import 'package:flutter/material.dart';
getWidthSize getWid = getWidthSize();
getHeightSize getHgt = getHeightSize();
getPosition getPos = getPosition();
getPrimaryColor color = getPrimaryColor();
getGenerated generateCard = getGenerated();
class getWidthSize{

  late double _size;
  set wSize(double value){
    if(value>0){
      _size = value;
    }
  }

  double get wSize => _size;


}

class getHeightSize{
  late double _size;
  set hSize(double value){
    if(value>0){
      _size = value;
    }
  }
  double get hSize => _size;
}

class getPosition{
  late double height;
  set hSize(double value){
    if(value>0){
      height = value;
    }
  }
  double get hSize => height;
}

class getPrimaryColor{
  late Color color;
  set col(Color value){
    color = value;
  }

  Color get col => color;
}

class getGenerated{
  late Map<String, String> _data = {}; // Private backing field

  // Getter for the map
  // Setter for the map
  set data(Map<String, String> newData) {
    if (newData.keys.every((key) => key is String) &&
        newData.values.every((value) => value is String)) {
      _data = newData;
    } else {
      throw ArgumentError('Map must have String keys and String values');
    }
  }
  Map<String, String> get data => _data;
}