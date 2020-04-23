import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alphabets.dart';
import '../widgets/word_decoration.dart';

class WordScreen extends StatelessWidget{
  static const routName='/wordScreen';
  @override
  Widget build(BuildContext context){
    final alpha=ModalRoute.of(context).settings.arguments as String;
    final words=Provider.of<Alphabets>(context,listen: false).searchByAlpha(alpha);
  
    return Scaffold(
      appBar: AppBar(
        title:Text(alpha)
      ),
      body:  ListView.builder(
            itemBuilder: ((ctx,i)=>WordDecoration(
              words[i].word
            )),
            itemCount: words.length,),
         );
  }
}