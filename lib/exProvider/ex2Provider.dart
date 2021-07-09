import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Ex2Provider with ChangeNotifier{
  String _vlaue = "안녕하세요";

  String get value => this._vlaue;
  set value(String v){
    this._vlaue = v;
    notifyListeners();
  }

  void add(String txt){
    this.value += txt;
    // this.value = this._value + txt;
  }
}