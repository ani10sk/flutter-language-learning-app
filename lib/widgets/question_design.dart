import 'package:flutter/material.dart';

class QuestionDesign extends StatelessWidget{
  final String question;
  QuestionDesign(this.question);
  @override
  Widget build(BuildContext context){
    return Card(
      margin:const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius:BorderRadius.circular(15)
        ),
        height:MediaQuery.of(context).size.height/4,
        width:double.infinity,
        padding:EdgeInsets.all(6),
        child: Text(question,
        style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold)
        ),
      ),
    );
  }
}