import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class KakaoLoginLogic{
  final String REST_API_KEY = '6187f758d291208aec58fa7c7384014d';
  final String REDIRECT_URI = 'http://192.168.219.107:3000/oauth';
  // String url =

  String kakaoUrl()=> 'https://kauth.kakao.com/oauth/authorize?client_id=$REST_API_KEY&redirect_uri=$REDIRECT_URI&response_type=code';

  Future<void> login() async{
    // String REST_API_KEY = 'String REST_API_KEY = 6187f758d291208aec58fa7c7384014d';
    // String REDIRECT_URI = 'http://192.168.219.118:3000/oauth';
    // String url = 'https://kauth.kakao.com/oauth/authorize?client_id=$REST_API_KEY&redirect_uri=$REDIRECT_URI&response_type=code';
    http.Response res= await http.get(Uri.parse(this.kakaoUrl()));
    print(res.body);
    return;
  }
}