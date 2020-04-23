import 'package:flutter/material.dart';
import '../screens/word_detail_screen.dart';

class WordDecoration extends StatelessWidget{
  final String word;
  WordDecoration(this.word);
  void selectWord(BuildContext ctx){
    Navigator.of(ctx).pushNamed(WordDetailScreen.routName,arguments: word);
  }
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10
      ),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: ()=>selectWord(context),
        child: Container(
          height:MediaQuery.of(context).size.height/5,
          alignment: Alignment.center,
          child:Text(word,
          style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [
              Colors.red.withOpacity(0.6),
              Colors.red
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
              ),
              borderRadius: BorderRadius.circular(15)
          ),
        ),
      ),
    );
  }
}