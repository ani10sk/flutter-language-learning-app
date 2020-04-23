import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget{
  static const routName='r-screen';
  @override
  Widget build(BuildContext context){
    final score=ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Result')
      ),
        body: Column(
          children: <Widget>[
            SizedBox(height:100),
            const Text('You have scored',style: 
            TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
            SizedBox(height:50),
            Center(
            child: Stack(
              children:[
                Container(
                  
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal:20
                  ),
                  height:270,
                  width:double.infinity,
                  child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTjCyWTL_rPd3JRm_HRjhavJ9IBHqMXD40kVL3t-iM0YNuSjDlx&usqp=CAU',
                  fit:BoxFit.fill,height: 300,width: 300,),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height:70),
                    Container(
                      alignment: Alignment.center,
                      child: Text(score==0 ?'00' :'$score',style: TextStyle(
                        fontSize:100,fontWeight:FontWeight.bold
                      ,),
                     textAlign: TextAlign.center, )
                      ),
                  ],
                )
              ]
            ),
      ),
          ],
        ),
    );
  }
}