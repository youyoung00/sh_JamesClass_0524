import 'package:flutter/foundation.dart';

class SubModel{
  String title;
  String name;
  String des;
  String image;

  SubModel({
    @required this.title,
    @required this.name,
    @required this.des,
    @required this.image
});

  SubModel.init(Map<String,dynamic> v){
    this.title = v["title"].toString();
    this.name = v["name"].toString();
    this.des = v["des"].toString();
    this.image = v["image"].toString();
  }

  factory SubModel.fInit(Map<String,dynamic> v){
    //return new SubModel();
    return new SubModel.init(v);
  }
}
