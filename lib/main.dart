import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/ex2Provider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/exProvider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/exview.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/logic/mainConnectData.dart';
import 'package:sh_selfstudy_ver0417/models/mainDataModel.dart';
import 'package:sh_selfstudy_ver0417/models/subConnectData.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';
import 'package:sh_selfstudy_ver0417/pages/loginPages.dart';
import 'package:sh_selfstudy_ver0417/providers/loginCheckProvider.dart';
import 'package:sh_selfstudy_ver0417/providers/mainProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pageTwo.dart';
import 'package:http/http.dart' as http;

void main(){runApp(new App());}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExProvider>(
          create: (_) => new ExProvider(),
        ),
        ChangeNotifierProvider<Ex2Provider>(
          create: (_) => new Ex2Provider(),
        ),
        ChangeNotifierProvider<MainProvider>(
         create: (_) => new MainProvider(),
         //   create:(_){
         //     //return new MainProvider()..init();
         //   MainProvider provider = new MainProvider();
         //   provider.init();
         //   return provider;
          // }
        ),
        ChangeNotifierProvider<LoginCheckProvider>(create: (_) => new LoginCheckProvider())
      ],
      child: new MaterialApp(
        // Widget - Build
        // home: MainPage(), // Build -> items()
        // home:MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider<Ex2Provider>(
        //       create: (_)=> new Ex2Provider(),
        //     )
        //   ],
        //   child: ExView(),
        // )
        home: new LoginCheckPage2(),

        /// *자동로그인
        /// 앱을 키면 -> 로그인을 했는지 ? -> : 누구나 -> 로그인이 되어있다면, 메인화면 / 아니면 로그인화면으로 이동.
        /// 로그인 기준 값 ? -> 휘발되지 않는 곳에 독립적인 저장이 필요 : 로컬 데이터 베이스DB - 파일을 사용해서 문자열을 저장, true<->false
        /// => SharedPref & Hive & Sqflite(SqlLite) & .....

      ),
    );
  }
}

class LoginCheckPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LoginCheckProvider provider = Provider.of<LoginCheckProvider>(context);
    bool check = provider.check;
    print(check);
    if(check == null) return Scaffold(body: Center(child: Text("로딩 중.."),),);
    if(!check) return LoginPage();
    // 로그인을 했다면 -> 토큰(사용자 고유 ID - 서버에서 부여한) 정상적인지 -> 서버랑 다시 체크
    // 토큰 - 특정 시간 마다 갱신(*리프레쉬 토큰) / jwt(token), Token
    return MainPage2();
  }
}


class LoginCheckPage extends StatefulWidget {

  @override
  _LoginCheckPageState createState() => _LoginCheckPageState();
}

class _LoginCheckPageState extends State<LoginCheckPage> {

  bool check;

  @override
  void initState() {
    Future(() async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      check = pref.getBool('check') ?? false;
      if(!mounted) return;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(check == null) return Scaffold(body: Center(child: Text("로딩 중..."),),);
    if(!check) return LoginPage();
    return MainPage2();
  }
}

// 다른 화면에서도 상태 또는 로직의 영향을 받게 할 것인가?
// * 모든 페이지에 영향을 주는 프로바이더
class MainPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => new LoginCheckPage2()
                )
              );
            },
          )
        ],
      ),
      // enum
      // @TODO(11일 금요일까지) : MainConnect Enum 적용해서 UI까지 수정
      body: this.items(provider.data)
    );
  }

  Widget items(MainConnectData data){
    if(data == null) return Container(
      child: Center(child: Text("Load...."),),
    );
    // if(data.data.length == 0)
    if(data.data.isEmpty) return Container(
      child: Center(child: Text("서버와의 연결의 오류가 발생했습니다."),),
    );
    //if(data.viewTxt == "서버와 연결이 지연되고 있습니다 다시 실행해주세요");
    return Container(
      child: GridView.builder(
        itemCount: data.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) => Container(
          child: Text(data.data[index].title),
        )
      ),
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
      // MainConnectData data = await this.connect.mainConnect();
      // this.vData = data.data;
      // this.viewLoadTxt = data.viewTxt;
      //
      // SubConnectData sData = await this.connect.subConnect(index: 0);
      // if(sData.check == null){
      //   print("LOADING");
      // }
      //
      // if(sData.check == SubConnectCheck.ServerTimeOut){
      //   print("ServerTimeOut");
      // }
      //
      // if(sData.check == SubConnectCheck.Error){
      //   print("Error");
      // }
      //
      // if(sData.check == SubConnectCheck.OK){
      //   print("OK");
      // }

      if(!mounted) return;
      setState(() {});
    });

    new Future(this.connect.connect);
    this.connect.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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


