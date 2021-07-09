import 'package:flutter/foundation.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';

class MainDataModel{
  String title;
  List<SubModel> datas;

  MainDataModel({
    @required this.title,
    @required this.datas
  });


  // 이름있는 생성자 사용 모델
  MainDataModel.init(Map<String,dynamic> e){
    this.title = e["title"].toString();
    this.datas = new List.from (e["datas"]).map<SubModel>((dynamic v){
      return new SubModel.fInit(v);
    }).toList();
  }

  // factory - 키워드
  // 자신의 인스턴스를 찍어내는 공장
  // 기본/이름있는 생성자들과의 차이 : return 해줘야 함. 자기자신의 인스턴스를 리턴 해줘야 함.
  // - 팩토리 메서드 (함수)
  // **** 여러 인스턴스를 생성할 경우 팩토리를 쓰면 좋다.

  factory MainDataModel.fInit(Map<String,dynamic> e){
    //return new MainDataModel();
    //return new MainDataModel.init();

    // (1)
    // return new MainDataModel(
    //     title: e["title"].toString(),
    //     datas: List.from (e["datas"]).map<SubModel>((v) => new SubModel.init(v)).toList()
    // );

    // 2
    return new MainDataModel.init(e);
  }
}



