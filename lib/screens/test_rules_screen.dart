import 'package:flutter/material.dart';
import './test_screen.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../providers/user.dart';
import './previous_result.dart';

class TestRulesScreen extends StatefulWidget{
  static const routName='test-rules';

  @override
  _TestRulesScreenState createState() => _TestRulesScreenState();
}

class _TestRulesScreenState extends State<TestRulesScreen> {
  @override
  Widget build(BuildContext context){
    User cuser=Provider.of<Users>(context,listen:false).cuser;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Test Rules')
      ),
      body: cuser.testStatus=='0'?
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: const Text('Currently test not available',style: TextStyle(
                      fontSize:30,fontWeight:FontWeight.bold
                    ),textAlign: TextAlign.center,)),
                ),
                FlatButton(
                  onPressed: ()=>Navigator.of(context).pushReplacementNamed(PreviousResultScreen.routName,
                  arguments: {'nuser':cuser.nuser,'date':cuser.tdate,'score':cuser.marks}),
                  child:const Text('Check Prevous Results',style:TextStyle(
                    fontSize: 15,fontWeight: FontWeight.bold
                  )))
              ],
            ):
            Container(
        padding:const EdgeInsets.all(10),
        margin:const EdgeInsets.symmetric(
          horizontal:10,
          vertical:30
        ),
        decoration:BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(15)
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            const Text('1. The test will consist of ten questions of 5 marks each',style:TextStyle(
              fontSize:20,fontWeight:FontWeight.bold
            )
            ),
            const Text('2. There will be no negative marking',style:TextStyle(
              fontSize:20,fontWeight:FontWeight.bold
            )
            ),
             const Text('3. There is no time constraint for the test and the candidate is allowed to attempt it only once',style:TextStyle(
              fontSize:20,fontWeight:FontWeight.bold
            )
            ),
            FlatButton(
              onPressed: ()=>Navigator.of(context).pushReplacementNamed(TestScreen.routName), 
              child:const Text('Proceed to test',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))
          ]
        )
      )
    );
  }
}