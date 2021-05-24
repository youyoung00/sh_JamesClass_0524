import 'package:flutter/material.dart';
import 'package:sh_selfstudy_ver0417/models/subModel.dart';

class pageth extends StatelessWidget {

  // Map<String, dynamic> sData;
  SubModel sData;
  pageth({@required this.sData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                      image: NetworkImage(this.sData.image)
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
                          this.sData.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(this.sData.name)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.deepPurple,
                  child: Text(this.sData.des),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
