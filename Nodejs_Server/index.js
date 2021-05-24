// cd 폴더 위치 이동
// pwd 현재 위치
// ls 현재 위치에서 갖고있는 목록 : 파일명/폴더명 - 이름
// ls -al : 자세히

// Dart 와 JS 차이 
// : Dart가 있는게 없음
// *** 타입-> 동적인 언어다
// JS('ES6')
// - 변수
// * 키워드 변수명 = 값;
// var, let 
var i = 1;
console.log(i);

i = "숫자를 넣어도 문자도 가능, 다른 타입이 가능";
console.log(i);

// JS는 없으면 만든다. -> 호이스팅
console.log(my);
var my = 123;

// let은 호이스팅 오류가 없다
// console.log(my2);
// let my2 = 321;
// - 상수 
// const 상수명 = 값;
const VALUE_CONST = 123;
// VALUE_CONST = 321; // 변경 불가 -> dart는 const, final(x)
function a(){return 321;}
const FUNC_VALUE_CONST = a();
console.log(FUNC_VALUE_CONST);

// 함수
// function 함수명(....){...}
function func1(){
    return 123;
}
var func1Value = func1();

var func2 = function(){};
func2();
(function(){})();

var func3 = () => 123;
var func32 = _ => 1233;
var func33 = _ => { return 12333; }

console.log(func3());
console.log(func32());
console.log(func33());

// 인자 
function funcA1(a,b,c){
    return a+b;
}

var funcA12 = (a,b,c) => a+b;
var funcA13 = (a,b,c) => {return a+b;}

// 인자를 전부 입력하지 않아도 오류 없음
// 필요한 인자만 입력 가능.
// 순서는 지켜야 함.
console.log( funcA1(1,2) );
console.log(funcA12(3,4,5));
console.log(funcA13(6,7));

// - 네이밍 옵션
// - 인자를 반드시 써야 함
function funcA2({a,b}){
    return a;
}
var funcA21 = ({a}) => a;

// * 인자를 입력하지 않았을 때 오류는 함수 생성에서 발생
console.log( funcA2( { b : 44, a : 123 } ) );
console.log( funcA21( { a : 321 } ) );
// Dart/Map - JS/OBj
// {키:값}
// -> 키: 문자열로 쓰지 않아도 가능
var argA2 = {"b":567, a:890};
console.log( funcA2(argA2) );

console.log( argA2["a"] );
console.log(argA2.a); // dart Class . <-> obj 객체 . : js 모든 값은 객체라고 할 수 있다.
console.log( argA2.b , argA2["b"]);

// Dart/List - JS/Array
var arr = [1,2,3];
console.log( arr[0], arr.length );

// - 네이밍 옵션 기본 값
function funcA3( a=123, {b,c} ){
    return a;

}
// null 빈 "값" // undefined 값이 없는 상태
console.log(funcA3( undefined, {b:3, c:1} ) );
console.log(funcA3( undefined, argA2 ) );

// js "[]" "{}" --> Json(JS 타입 형태/표현)

// --- class / OOP 객체지향을 주로 사용하지 않음 -> function 함수프로그래밍 주로 사용했었지만 .. 현재는 변화..
// 작성 방법
// class 클래스명{} 
// new 클래스명();

class Main{
    // 변수, 함수들
    i = 123; // var 키워드를 적지 않음
    aa(){return 123123;} // function 키워드 적지 않음
    aa2 = function(){return 555;};
    aa3 = () => 666;

 // 생성자 - dart : 클래스 명과 같은 이름인 함수를 만들면 되었음
 constructor(i, a){
     // - 클래스의 인스턴스가 생성될 때 실행 (가장 먼저 실행 된다.)
     // - 클래스의 변수에 할당 가능 
     this.bb();
     this.i = i;
     this.a = a;
 }

 bb(){console.log(this.a,this.i);}

 // static
 static aS = 321321;
 static aF(){ return this.aS;}
 static aF2(){ return Main.aS;}

}
var main = new Main(9, 10);
console.log( main );
main.bb();
Main.aF()
console.log(Main.aF2() );
console.log(Main["as"]);

// oop상속, extends
// abstract - implements 없음, MixIn 없음
class First{
    constructor(fCons){
        this.value = 123;
        this.fCons = fCons;
    }
    firstPrint = _ => console.log(`value : ${this.value}, / fCons: ${this.fCons}`);
    firstPrint2 = function(){console.log(`value : ${this.value}, / fCons: ${this.fCons}`);
}
// 화살표 함수, funtion함수든, 키워드생략함수든 sec Class에서 super 접근하므로 First class 무엇이든 상관없음
firstPrint3(){
    console.log(`value : ${this.value}, / fCons: ${this.fCons}`);
}

}

var fClass = new First(555);
fClass.firstPrint();

class Sec extends First{
    // 추가(변수, 메서드, 생성자) 기존 수정(변수 값, 메서드 처리) - 기존을 포함하여 확장
    // 오버라이드 (@override) 기존 값 수정 메서드처리
    value2 = 321;
    constructor(sCons){
       
        super(sCons).value3 = 444; // this super 만은 안됨
 
    //     // new First(fcons).value3 추가한 것.....
    // @변수를 오버라이드 할때는 순서를 지켜야 함.
    super.value = 888;
    }

    //firstPrint = _ => console.log(`value : ${this.value}, / fCons: ${this.fCons}`);
    //firstPrint = _ => console.log("SEC - FirstPrint");
    firstPrint = _ => {
        console.log("SEC - FirstPrint 2222222");
        // super().firstPrint(); 오류로 못씀

    }
    firstPrint2 = function(){
        console.log("SEC - FirstPrint 33333");
        // super(888).firstPrint2(); 오류로 못씀
    }

    firstPrint3(){
        console.log("SEC - FirstPrint 444444");
        super.firstPrint3();    
    }
    secPrint = _=> console.log(this.value, this.value2, this.value3);
}

var sClass = new Sec(777);
sClass.value;
sClass.firstPrint3();

sClass.firstPrint();
console.log(sClass.value2, sClass.value3);
sClass.secPrint();

/////////////////////////
// Node = Express : HTTP 서버 만들기(tcp, udp, tfp, ftp, smtp)
// - 코드를 다운(web - html 파일을 다운 / app - apk, apple)
// - 중간 다리 역할 (사용자와 데이터의)
// - 실시간 수정 가능, 데이터를 독립적으로 관리할 수 있게 됨.


// * 정보를 관리하는 파일 생성(Flutter pubspec 파일과 같은 것.)
// 터미널 $ > npm init

// * 패키지 다운(pub get 과 동일)
// 터미널 >,$> 터미널에서 입력하라는 뜻. npm i -s express
// 

// * 패키지를 호출하는 import
var express = require("express");
var app = express();

// HTTP 서버를 열기 위해서 port 포트 지정이 필요
// * ip + port 주소가 됨. -> url(uri)
// * -- HTTP 80번 / HTTP 443번 써서 배포하도록 약속되어있음, (특히 https 무조건 443번)
app.listen(3000);

// 주문(요청req, requesst) 방식
// GET : 비암호화 적용 - 주소창을 통해서 공개
// POST : 암호화가 적용 - 일반적으로는 볼수 없음

// 라우터(4), (5)
app.get('/', (req, res) => res.json([1,2,3])); // => Flutter : 단순 문자열로 
app.get('/app', (req, res) => res.json("<h1>데이터<h1/>")); // "" '' {} [] // -> 웹 플러터 모두 단순문자열 처리

// http
// req = [ header(요청자의 정보: ip주소 등...) & Body(요청자가 보내는 데이터) ]
// res = [ header(응답자의 정보: ip주소 등...) & Body(응답하는 데이터)]

// 6. 요청자가 모바일이면 json 반환 / web이면 html 반환
app.get('/check', (req,res) => {
    var reqCheck = req.headers["user-agent"];
    var index = reqCheck.indexOf("Chrome");
    if(index > -1){
        return res.send("안녕하세요, 웹?");
    }
    return res.json("안녕하세요, 모바일 ?");
});

// nodemon -> 저장하면 재실행해주는 패키지
// sudo npm i -g nodemon
// nodemon index.js로 실행,

// 서버요청의 종류
// 1. 주소(path) -- 정적 & 동적
// 2. 쿼리스트링(qs)

// 동적으로 구성되어있을 때, 필요한 정적 라우터는 상위에 작성.
app.get('/check/123', (req,res) => res.json("123123"))
app.get('/check/:date', (req,res) => {
    var date = req.params.date;

    var id = req.query.id;

    res.send(`date: ${date} / id:${id}`);
});


var datas = [
   
  {
    "title" : "댄스",
    "datas" : [
        {"title" : "댄스노래1", 
        "name" : "댄스가수1",
        "des" : "댄스가사1", 
        "image": "https://cdn.pixabay.com/photo/2020/09/20/14/08/woman-5587219__480.jpg"
      },
      {
        "title" : "댄스노래2",
        "name" : "댄스가수2",
        "des" : "댄스가사2",
        "image": "https://cdn.pixabay.com/photo/2021/04/26/10/48/lake-6208614__480.jpg"
      }
    ]
  },
  {
    "title" : "발라드",
    "datas" : [
      {
        "title" : "발라드노래1",
        "name" : "발라드가수1",
        "des" : "발라드가사1",
        "image": "https://cdn.pixabay.com/photo/2020/01/21/16/26/yorkshire-terrier-4783327__480.jpg"
      },
      {
        "title" : "발라드노래2",
        "name" : "발라드가수2",
        "des" : "댄스가사2",
        "image": "https://cdn.pixabay.com/photo/2020/01/21/16/26/yorkshire-terrier-4783327__480.jpg"
      }
    ]
  }
];

app.get('/datas', (req,res) => {
    // xml, string, html ... 
    res.json(datas);
});

app.get('/data/:id',(req,res) => {
    var id = req.params.id;
    res.json(datas [id] );
});




