import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/models/mainDataModel.dart';
import 'package:sh_selfstudy_ver0417/models/subConnectData.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';
import 'package:sh_selfstudy_ver0417/pageth.dart';
import 'package:http/http.dart' as HTTP;

class PageTwo extends StatefulWidget {
  // int i;
  // PageTwo(this.i);
  int index;
  String title;
  List <SubModel> datas;
  PageTwo({@required this.title, @required this.datas, @required this.index});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {

  SubConnectData viewData;

  @override
  void initState() {
    new Future(() async{
      this.viewData = await new Connect().subConnect(index: widget.index);
      if(!mounted) return;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      // body: ListView(
      //   children: [
      //     this._items(context),
      //     this._items(context),
      //     this._items(context),
      //     ListTile(
      //       leading: Icon(Icons.padding),
      //       title: Text("타이틀"),
      //       subtitle: Text("내용..."),
      //       trailing: Icon(Icons.navigate_next_outlined),
      //     ),
      //   ],
      // ),
      // body: this.viewData == null
      //     ? Container(child: Center(child: Text("Load...."),),)
      //     : this.viewData.check == SubConnectCheck.Error
      //       ? Center(child: Text("오류 발생"),)
      //       : this.viewData.check == SubConnectCheck.ServerTimeOut
      //         ? Center(child: Text("서버 지연 발생"),)
      //         : ListView.builder(
      //     //itemCount: this.widget.datas.length,
      //     itemCount: this.viewData.mainDataModel.datas.length,
      //     itemBuilder: (BuildContext context, int index){
      //     // return this._items(context);
      //     return ListTile(
      //       onTap: () => Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => new pageth(
      //             sData: this.widget.datas[index],
      //             index: widget.index, // 장르번호
      //             targetindex: index, // 선택한 노래 번호
      //           )
      //         )
      //       ),
      //       leading: Icon(Icons.padding),
      //       //title: Text(this.widget.datas[index].title),
      //       title: Text(this.viewData.mainDataModel.datas[index].title),
      //       subtitle: Text(this.widget.datas[index].name),
      //       trailing: Icon(Icons.navigate_next_outlined),
      //     );
      //   }
      // ),
      body: this._checkWidget(this.viewData),
    );
  }

  Widget _checkWidget(SubConnectData viewData){
    if(viewData == null) return Container(child: Center(child: Text("Load...."),),);
    if(viewData.check == SubConnectCheck.Error) return Center(child: Text("오류 발생"),);
    if(viewData.check == SubConnectCheck.ServerTimeOut) return Center(child: Text("서버 지연 발생"),);
    return ListView.builder(
      //itemCount: this.widget.datas.length,
        itemCount: viewData.mainDataModel.datas.length,
        itemBuilder: (BuildContext context, int index){
          // return this._items(context);
          return ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new pageth(
                  sData: this.widget.datas[index],
                  index: this.widget.index, // 장르번호
                  targetindex: index, // 선택한 노래 번호
                )
              )
            ),
            leading: Icon(Icons.padding),
            //title: Text(this.widget.datas[index].title),
            title: Text(viewData.mainDataModel.datas[index].title),
            subtitle: Text(viewData.mainDataModel.datas[index].name),
            trailing: Icon(Icons.navigate_next_outlined),
        );
      }
    );
  }

  Widget _items(BuildContext context){
    return Container(
      // color: Colors.orange,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width/10,
            // color: Colors.red,
            child: Icon(Icons.access_alarm),
          ),
          Container(
            width: ((MediaQuery.of(context).size.width/10)*8)-40.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            // color: Colors.yellow,
            child: Column(
              children: [
                Text(
                  "타이틀",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5.0,),
                Text("내용..."),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width/10,
            // color: Colors.red,
            child: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
