import 'package:flutter/material.dart';

class Options extends StatefulWidget{
  final String answer;
  final String option1;
  final String option2;
  final Function upDateScore;
  final List<String> list=[];
  Options(this.upDateScore,this.answer,this.option1,this.option2){
      list.add(answer);
      list.add(option1);
      list.add(option2);
      list.shuffle();
  }
  
 
  Color color=Colors.red[100];
  Color ccolor=Colors.red[100];
  Color wcolor=Colors.red[100];
  int index=0;
  var answerStatus=true;
  @override
  _OptionsState createState()=>_OptionsState();
}

class _OptionsState extends State<Options>{
  static int qstNo=0;
   //static int score=0;
  void checkAnswer(String option,int index){
    widget.answerStatus=false;
    if(option==widget.answer){
      setState(() {
        widget.ccolor=Colors.green;
        widget.upDateScore(10);
      });
    }else{
      setState(() {
        widget.index=index;
        widget.ccolor=Colors.green;
        widget.wcolor=Colors.red;
      });
    }
    qstNo=qstNo+1;
  }
  @override
  Widget build(BuildContext context){
   return ListView.builder(
        itemBuilder: (ctx,i)=>widget.list[i]==widget.answer ?
        optionDesign(widget.list[i],widget.ccolor,i,context):i==widget.index ?
        optionDesign(widget.list[i], widget.wcolor, i,context):
        optionDesign(widget.list[i], widget.color,i,context),
        itemCount: widget.list.length,
    );
  }
  Widget optionDesign(String option,Color color,int index,BuildContext ctx){
    return GestureDetector(
      onTap: ()=>widget.answerStatus? checkAnswer(option,index):  Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: const Text('Answer cannot be undone'),
          duration: Duration(seconds:2),
          )
          ),
      child: Card(
        margin: EdgeInsets.all(20),
        child:Container(
          alignment: Alignment.center,
          height:50,
          color:color,
          child: Text(option,
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}