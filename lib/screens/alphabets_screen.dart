import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../widgets/alpha_decoration.dart';
import '../providers/alphabets.dart';

class AlphabetsScreen extends StatefulWidget{
  static const routName='alphabets';
  @override
  _AlphabetsScreenState createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  final List<Color> colors=[Colors.red,Colors.amber,Colors.blue,Colors.cyan,Colors.deepOrange,
  Colors.green,Colors.lightBlue,Colors.lightGreen,Colors.pink,Colors.yellow];

  var isLoading=true;

  var isInit=true;

  //final aitems=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    //'Q','R','S','T','U','V','W','X','Y','Z'];

  @override
  void didChangeDependencies() {
    if(isInit){
      setState(() {
      isLoading=true;
    });
    Provider.of<Alphabets>(context,listen: false).retreive().then((_){
      setState(() {
        isLoading=false;
      });
    });
    }
    isInit=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context){ 
    const items=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    return Scaffold(
      appBar: AppBar(
        title:const Text('Alphabets'),
      ),
      drawer: AppDrawer(),
      body:isLoading ? Center(child:CircularProgressIndicator()) :
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
            
           itemBuilder: (ctx,i)=>AlphabetDecoration(
             colors[Random().nextInt(10)],
             items[i]),
           itemCount:items.length,
           ),
      );
  }
}