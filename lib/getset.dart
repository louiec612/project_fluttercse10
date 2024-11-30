getWidthSize getWid = getWidthSize();
getHeightSize getHgt = getHeightSize();
getPosition getPos = getPosition();
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