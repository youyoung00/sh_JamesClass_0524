// @ TODO: 새로운 페이지(노래정보 페이지) 만들어서 서버에서 노래정보를 받아서 화면에 표현
// @ TODO: [28일 금요일에 provider 수업함.]

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sh_selfstudy_ver0417/models/mainDataModel.dart';
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

  MainDataModel viewData;

  Future<void> subConnect() async{
    HTTP.Response res = await HTTP.get(Uri.parse("http://192.168.219.131:3000/data/${widget.index}"));
    Map<String,dynamic> data = json.decode(res.body);
    this.viewData = MainDataModel.fInit(data);
    print(viewData.title);
    return;

  }

  @override
  void initState() {
    new Future(() async{
      await this.subConnect();
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
      body: this.viewData == null
          ? Container(child: Center(child: Text("Load...."),),)
          : ListView.builder(
          //itemCount: this.widget.datas.length,
          itemCount: this.viewData.datas.length,
          itemBuilder: (BuildContext context, int index){
          // return this._items(context);
          return ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new pageth(
                  sData: this.widget.datas[index],
                )
              )
            ),
            leading: Icon(Icons.padding),
            //title: Text(this.widget.datas[index].title),
            title: Text(this.viewData.datas[index].title),
            subtitle: Text(this.widget.datas[index].name),
            trailing: Icon(Icons.navigate_next_outlined),
          );
        }
      ),
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
