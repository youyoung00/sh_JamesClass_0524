import 'package:flutter/foundation.dart';
import 'package:sh_selfstudy_ver0417/logic/pref.dart';

class LoginCheckProvider with ChangeNotifier{

  Pref _pref;
  bool _check;

  bool get check => this._check;

  LoginCheckProvider(){
    //this._init();
    Future.microtask(this._init);
  }

  Future<void> _init() async{
    // this._pref = new Pref();
    await this.getLoginCheck();
    print("LOGINCHECKPROVIDER");
    return;
  }

  Future<void> getLoginCheck() async{
    // this._check = await this._pref.getLoginCheck();
    this._check = await Pref.getLoginCheck();
    notifyListeners();
    return;
  }

  Future<void> setLoginCheck(bool value) async{
    await Pref.setLoginCheck(value);
    await this.getLoginCheck();
    return;
  }

  Future<void> clear() async{
    await Pref.clear();
    await this.getLoginCheck();
    return;
  }

}