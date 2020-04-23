import 'package:flutter/material.dart';
import '../screens/word_screen.dart';

class AlphabetDecoration extends StatelessWidget{
  final Color color;
  final String alphabet;
  void selectAlpha(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      WordScreen.routName,
      arguments: alphabet);
  }
  AlphabetDecoration(this.color,this.alphabet);
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: ()=>selectAlpha(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
        child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Text(alphabet,
        style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(gradient: LinearGradient(
          colors: [
            color.withOpacity(0.6),
            color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}