import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviousResultScreen extends StatelessWidget{
  static const routName='previous-results';
  @override
  Widget build(BuildContext context){
    final routArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final nuser=routArgs['nuser'];
    final date=routArgs['date'];
    final score=routArgs['score'];
    final DateTime d=DateTime.parse(date);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Results')
      ),
      body: nuser=='1' ?
      Center(
      child:Card(
        elevation:5,
        margin:EdgeInsets.symmetric(
          horizontal:10,
        ),
        color:Colors.yellow[300],
        child: const Text('No test attempted till now',style: TextStyle(
          fontSize:20,fontWeight:FontWeight.bold
        ),),
      )

    ):Center(
          child: Container(
        height:250,
        width: 250,
        alignment: Alignment.center,
        margin:const EdgeInsets.symmetric(
          horizontal:15,
          vertical:80
        ),
        padding:const EdgeInsets.all(15),
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(15),
          color: Colors.yellow[300]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
             Text(DateFormat('dd/MM/yyyy').format(d),style:TextStyle(
              fontSize:30,
              fontWeight:FontWeight.bold
            )),
            Text(score,style:TextStyle(
              fontSize:90,
              fontWeight:FontWeight.bold
            ))
          ],
        ),

      ),
    )
    );
  }
}