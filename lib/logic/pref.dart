import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// TODO : 28일 Staric 자체 재진행 & Static 으로 변경 예정 (싱글턴 기법 활용)
class Pref{
// class new Pref();
  // Pref(){
  //   Future.microtask(this._init);
  // }

  static SharedPreferences _pref;
  static final String loginCheckKey = 'check';

  static Future<SharedPreferences> _init() async{
    if(Pref._pref == null){
      Pref._pref = await SharedPreferences.getInstance();
    }
    return Pref._pref;
  }

  // SharedPreferences check = await Pref._init();
  // return check.getBool(Pref.loginCheckKey) ?? false;
  //bool check = await Pref._init()..getBool(Pref.loginCheckKey);
  // .. 를 쓰면 이후 실행되는 getBool의 결과가 아닌 _init의 결과를 반환하기 때문에 줄여쓸 수 없다.

  // then
  static Future<bool> getLoginCheck() async
  => await Pref._init().then<bool>((SharedPreferences value) => value.getBool(Pref.loginCheckKey) ?? false);

  static Future<void> setLoginCheck(bool value) async
  => await (await Pref._init()).setBool(Pref.loginCheckKey, value);

  static Future<void> clear() async => await Pref._init().then((SharedPreferences s) => s.clear());

}