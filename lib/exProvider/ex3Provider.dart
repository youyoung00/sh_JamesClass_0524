import 'package:flutter/foundation.dart';

class Ex3Provider with ChangeNotifier{

  String value;
  Ex3Provider(this.value);

  void add(String v){
    this.value += value;
    notifyListeners();
  }

}