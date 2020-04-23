import '../widgets/app_drawer.dart';
import '../widgets/word_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alphabets.dart';

class AllWordsScreen extends StatelessWidget{
  static const routName='/all-words';
  @override
  Widget build(BuildContext context){
    final alpha=Provider.of<Alphabets>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
        title:const Text('All words of the week')
      ),
      drawer: AppDrawer(),
      body: 
      ListView.builder(
        itemBuilder: (ctx,i)=>WordDecoration(alpha.items[i].word),
        itemCount: alpha.items.length,)
    );
  }
} 