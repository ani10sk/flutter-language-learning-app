import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/questions.dart';
import '../widgets/question_design.dart';
import '../widgets/options.dart';
import '../screens/result_screen.dart';
import '../providers/users.dart';

class TestScreen extends StatefulWidget{
  static const routName='test-screen';
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  
  var isWaiting=false;

  @override
  void didChangeDependencies(){
    setState(() {
      isWaiting=true;
    });
    Provider.of<Questions>(context,listen: false).fetchTest().then((_){
      setState(() {
        isWaiting=false;
      });
    });
    super.didChangeDependencies();
  }

  /*Future<void> addQuestion(BuildContext context)async{
        print('hello');
       await Provider.of<Questions>(context,listen:false).insertData();
    }*/
  int score=0;
  void upDateScore(int value){
    score=score+value;
  }
  int i=0;  

  Future<void> finishTest()async{
    Users pd=Provider.of<Users>(context,listen: false);
    pd.cuser.testStatus='0';
    pd.cuser.marks=score.toString();
    pd.cuser.nuser='0';
    pd.updateUser(pd.cuser);
    Navigator.of(context).pushReplacementNamed(ResultScreen.routName,arguments:score);
  }

  @override
  Widget build(BuildContext context){
    final tst=Provider.of<Questions>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Test'),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed:()=> addQuestion(context))
        ],*/
      ),
      body: isWaiting ?Center(
        child:CircularProgressIndicator()
      ):SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
          Text('Question  ${i+1}',style: TextStyle(
            fontSize:23,fontWeight:FontWeight.bold
          ),
          textAlign: TextAlign.center,),
          QuestionDesign(tst.test[i].question),
          SizedBox(height:30),
          SizedBox(height:300,child:  Options(upDateScore,tst.test[i].answer,tst.test[i].option1,tst.test[i].option2),),
          i==tst.test.length-1 ?
          FlatButton(
            onPressed:finishTest,
            child: const Text('Finish test')
            ):
            FlatButton(
              onPressed: ()=>setState((){
                i=i+1;
              }),
              child:const Text('Next Question')
              )
          ]),
      )
    );
  }
}