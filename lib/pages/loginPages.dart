import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/logic/kakaoLoginLogic.dart';
import 'package:sh_selfstudy_ver0417/main.dart';
import 'package:sh_selfstudy_ver0417/providers/loginCheckProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {

  // 25일(금) 리펙토링: Connect.dart -->

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idCt = TextEditingController();
  TextEditingController pwCt = TextEditingController();

  FocusNode idf = FocusNode();
  FocusNode pwf = FocusNode();

  Connect connect = new Connect();

  @override
  void dispose() {
    this.idCt?.dispose();
    this.pwCt?.dispose();
    super.dispose();
  }

  LoginCheckProvider loginCheckProvider;

  @override
  Widget build(BuildContext context) {
    if(loginCheckProvider == null){
      loginCheckProvider = Provider.of<LoginCheckProvider>(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        // controller: ,
        // TODO 21일 클릭하면 필드로 스크롤 이동부터
        //physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height-kToolbarHeight-MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          //color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 400,
                color: Colors.red,
              ),
              //Row(),
              Container(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: this.idCt,
                  focusNode: this.idf,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    border: InputBorder.none,
                    hintText: "ID"
                  ),
                ),
              ),
              Container(
                width: 200,
                child:
                TextField(
                  controller: this.pwCt,
                  focusNode: this.pwf,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      border: InputBorder.none,
                      hintText: "PW"
                  ),
                ),
              ),
              TextButton(
                onPressed: ()async{
                  print(this.idCt.text);
                  print(this.pwCt.text);

                  bool check = await this.connect.loginConnect(
                      id: this.idCt.text,
                      pw: this.pwCt.text
                  );

                  if (!check){
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context)=> AlertDialog(
                          title: Text("ID, PW를 확인해주세요"),
                          actions: [
                            TextButton(
                              child: Text("닫기"),
                                onPressed: () => Navigator.of(context).pop(),)
                          ],
                        )
                    );
                  }
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  await pref.setBool('check', true);
                  /// TODO : 로그아웃 & 리팩토링 & stf -> 프로바이더로
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainPage2()
                    )
                  );
                },
                child: Text("Login"),
              ),
              TextButton(
                child: Text("KakaoLogin"),
                onPressed: () async{
                   KakaoLoginLogic kakao = new KakaoLoginLogic();
                  // await kakao.login();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(),
                        body: SafeArea(
                          child: WebView(
                            initialUrl: kakao.kakaoUrl(),
                            javascriptMode: JavascriptMode.unrestricted,
                            javascriptChannels: {
                              JavascriptChannel(
                                name: "flutter",
                                onMessageReceived: (JavascriptMessage msg){
                                  print(msg.message);
                                  if(msg.message == "1"){
                                    Navigator.of(context).pop();
                                    loginCheckProvider.setLoginCheck(true);
                                    Future.microtask(() async => await loginCheckProvider.setLoginCheck(true));
                                  }
                                  return;
                                }
                              )
                            },
                          ),
                        ),
                      )
                    )
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}