import 'package:flutter/foundation.dart';

// stf -> 변수와 setState() 역할을 대체
class ExProvider with ChangeNotifier{

  int i = 0;

  void add(){
    this.i += 1;
    // this.i = this.i + 1;
    notifyListeners();
  }
  void minus(){
    this.i -= 1; //this.i = this.i -1;
    notifyListeners();
  }
}