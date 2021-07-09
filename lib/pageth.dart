import 'package:flutter/material.dart';
import 'package:sh_selfstudy_ver0417/logic/Connect.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';

class pageth extends StatefulWidget {

  // Map<String, dynamic> sData;
  SubModel sData;
  int index;
  int targetindex;
  pageth({@required this.sData,@required this.index, @required this.targetindex});


  @override
  _pagethState createState() => _pagethState();
}

class _pagethState extends State<pageth> {

  SubModel datailViewData;

  @override
  void initState() {
    Future(() async{
      this.datailViewData = await new Connect().detailConnect(index: widget.index, targetIndex: widget.targetindex);
      print(this.datailViewData);
      if(!mounted) return;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: this.datailViewData == null
        ? Center(child: Text("Load..."),)
        : SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        this.datailViewData.image
                      )
                      //this.widget.sData.image)
                    )
                  ),
                ),
                Container(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(
                    vertical: 20.0
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                    this.datailViewData.title,
                          //this.widget.sData.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        this.datailViewData.name,
                          //this.widget.sData.name
                        )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.deepPurple,
                  child: Text(
                      this.datailViewData.des//this.widget.sData.des
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
