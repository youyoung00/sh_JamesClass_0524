import 'package:flutter/foundation.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/logic/mainConnectData.dart';

class MainProvider with ChangeNotifier{
  Connect _connect = new Connect();
  MainConnectData data;

  Future<void>_init() async{
    this.data = await this._connect.mainConnect();
    notifyListeners();
    return;
  }

  MainProvider(){
    Future(this._init);
    // Future( () async => await this._init());
  }

}