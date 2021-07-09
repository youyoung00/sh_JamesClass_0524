import 'package:flutter/foundation.dart';
import 'package:sh_selfstudy_ver0417/models/mainDataModel.dart';

// enum
enum SubConnectCheck{
  Error,
  Load,
  OK,
  ServerTimeOut,
}

// MainDataModel
// check
class SubConnectData{
  MainDataModel mainDataModel;
  //SubConnectCheck check = SubConnectCheck.Load;
  SubConnectCheck check;
  SubConnectData({@required this.mainDataModel, @required this.check,});


}