import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/models/mainConnectData.dart';
import 'package:sh_selfstudy_ver0417/models/mainDataModel.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';
import 'pageTwo.dart';
import 'package:http/http.dart' as http;



void main(){runApp(new App());}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // Widget - Build
      home: MainPage(), // Build -> items()
    );
  }
}

// Widget
class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<MainDataModel> vData;
  String viewLoadTxt = "로딩 중...";
  Connect connect = new Connect();

  @override
  void initState() {

    Future(() async{
      MainConnectData data = await this.connect.mainConnect();
      this.vData = data.data;
      this.viewLoadTxt = data.viewTxt;
      if(!mounted) return;
      setState(() {});
    });

    new Future(this.connect.connect);
    this.connect.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // ...
    // ---> Flutter Build 가 언제 시작되는지 정확히 제어 불가능
    // ---> Build 한번만 실행 된다는 보장이 없음

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        // leading: Container(),
        backgroundColor: Colors.green,
        title: Text("LOGO"),
        centerTitle: true,
        // (1)
        actions: [
          new IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              // ...
              return;
              // print("asd"); // 동작 X
            },
          ),
        ],
        // (2) 변수
        // actions: this._myActions,
        // (3) 함수
        // actions: this._myFuncActions(),
        // (4 - 1) 클래스
        // actions: [ new MyIconSetting1() ],
        // (4 - 2) 리스트<클래스>
        // (4 - 2 - 1)
        // actions: new PartActions().actionsWidget(),
        // (4 - 2 - 2)
        // actions: this._partActions.actionsWidget(),
        // (4 - 2 - 3)
        // actions: this._partActions.actionsWidget2,
        // (4 - 2 - 4)
        // actions: PartActions.actionsWidget3,
        // (4 - 2 - 5)
        // actions: PartActions.actionsWidget4(),
      ),
      body: this.vData == null
        ? Center(child: Text(this.viewLoadTxt),)
        : new GridView.builder(
        padding: new EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        // scrollDirection: Axis.horizontal,
        // children: [
        //   this._items(), // new Containr(....)
        //   this._items(), // new Containr(....)
        //   this._items(), // new Containr(....)
        //   this._items(), // new Containr(....)
        //   this._items(), // new Containr(....)
        //   Container(color: Colors.blue,),
        //   Container(color: Colors.yellow,),
        // ],
        // children: [1,2,3,4,5].map<Widget>((int e) => this._items(e)).toList(),
        // [ new Container(...), ... , ... , ... , ]
        // itemCount: this.sData.length, // 6개 // 2개...+-
        itemCount: this.vData.length,
        itemBuilder: (BuildContext context, int i){ // 0번째,1번째,2..,3..,4..,5.., itemCount-1번째까지 반복 --> List
          // return Container();
          return this._items(i, context); // data[0]
        },
      ),
    );
  }

  List<int> data = [1,2,3,4,5,6];

  Widget _items(int i, BuildContext context){
    // InkWell
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context){
              // return Scaffold(appBar: AppBar(),);
              return new PageTwo(
                // title: this.sData[i]['title'].toString(),
                // datas: List.from(this.sData[i]['datas'])
                index: i,
                title: this.vData[i].title,
                datas: this.vData[i].datas,
              );
            }
          )
        );
        // push
        // pop

        return;
      },
      child: new Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.orange,
              child: Icon(Icons.more_horiz),
              // width: (MediaQuery.of(context).size.width/2)-15.0,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10.0),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              // color: Colors.red,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(60.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://images.unsplash.com/photo-1611095965923-b8b19341cc29?ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")
                  )
              ),
            ),
            Container(
              child: Text(
                // this.sData[i]["title"].toString(), // dynamic
                this.vData[i].title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
            Container(
              // alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Icon(Icons.access_alarm)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyIconSetting1 extends StatelessWidget {
  // 변수 및 함수를 사용 할 수 있음
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: (){
        print("CLASS MyIconSetting을 누름");
      },
    );
  }
}

class PartActions{
  List<Widget> actionsWidget(){
    return [ new MyIconSetting1() ];
  }

  List<Widget> actionsWidget2 = [ new MyIconSetting1() ];

  static List<Widget> actionsWidget3 = [ new MyIconSetting1() ];

  static List<Widget> actionsWidget4(){
    return [ new MyIconSetting1() ];
  }
}


