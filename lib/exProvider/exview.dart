import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/ex2Provider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/ex3Provider.dart';
import 'package:sh_selfstudy_ver0417/exProvider/exProvider.dart';

// @TODO : 9일 프로바이더에 기능을 붙여보기, 여러 개 써보기

class ExView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExProvider provider = Provider.of<ExProvider>(context);
    Ex2Provider provider2 = Provider.of<Ex2Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(provider2.value),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => ChangeNotifierProvider<Ex3Provider>(
                    create: (_) => Ex3Provider(provider2.value),
                    child: ExView2(provider2)
                  )
                )
              );
            },
              icon: Icon(Icons.person)
          ),
          IconButton(onPressed: (){
            provider2.add("홍길동님");
          },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Center(child: Text(provider.i.toString()),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: provider.add,
      ),
    );
  }
}

class ExView2 extends StatelessWidget {
  Ex2Provider ex2provider;
  ExView2(this.ex2provider);
  @override
  Widget build(BuildContext context) {
    ExProvider provider = Provider.of<ExProvider>(context);
    Ex3Provider provider3 = Provider.of<Ex3Provider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.i.toString()),
        actions: [
          IconButton(onPressed: (){
            provider.minus();
          },
          icon: Icon(Icons.exposure_minus_1))
        ],
      ),
      body: Column(
        children: [
          Text(this.ex2provider.value),
          Text(provider3.value)
        ],
      ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          // this.ex2provider.add("백두산님");
          provider3.add("한라산님");
        },
      ),
    );
  }
}


