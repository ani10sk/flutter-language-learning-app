import 'package:flutter/material.dart';
import '../widgets/login.dart';
import '../widgets/signUp.dart';

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreenState createState()=>_AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{
  var option=1;
  Widget build(BuildContext context){
    final deviceSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text('VocEnhancer'),
        actions:[
          option==1?
          Container(
            width:80,
            margin: const EdgeInsets.all(5),
            padding:const EdgeInsets.symmetric(
              horizontal: 5
            ),
            child: RaisedButton(
              color: Colors.green,
                child: const Text('Sign up here',
                style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              onPressed: ()=>setState((){
                option=0;
              }),
            ),
          ): Container(
            width:80,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(
              horizontal: 5
            ),
            child: RaisedButton(
              color: Colors.green,
                child: const Text('Log In',
                style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              onPressed: ()=>setState((){
                option=1;
              }),
            ),
          )
        ]
      ),
      body: Stack(
        children:[
          Container(
            width: deviceSize.width,
            height:deviceSize.height,
            child: Image.asset('assets/bgImage.png',fit: BoxFit.fill)
            ),
          Column(
            children:[
              SizedBox(height: 120,),
              option==1 ?
          LogIn(deviceSize):
          SignUp(deviceSize)
            ]
          )
          
        ]
      )
    );
  }
}