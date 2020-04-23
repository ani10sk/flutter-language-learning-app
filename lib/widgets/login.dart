import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget{
  final Size deviceSize;
  LogIn(this.deviceSize);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> form=GlobalKey();
  var isLoading=false;

  void showErrorDialog(String message){
    showDialog(
      context: context,
      builder: (ctx)=>
      AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed:()=> Navigator.of(context).pop(),
            child: const Text('OK'))
        ],
      )
      );
  }

  Future<void> sumbmit()async{
    if(!form.currentState.validate()){
      return;
    }
    form.currentState.save();
    setState(() {
      isLoading=true;
    });
    try{
      await Provider.of<Auth>(context,listen: false).logIn(
      userInfo['email'],userInfo['password']
    );
    }catch(error){
      showErrorDialog('Could not log in please check details');
    }
    setState(() {
      isLoading=false;
    });
  }

  Map<String,String> userInfo={
    'email':'',
    'password':''};

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      height: 250,
      margin: const EdgeInsets.symmetric(
        horizontal:50
      ),
      padding: const EdgeInsets.symmetric(
        horizontal:10,
        vertical:20
      ),
      child:Form(
        key: form,
        child: ListView(
          children:[
            TextFormField(
              decoration:const InputDecoration(labelText:'Email'),
              keyboardType:  TextInputType.emailAddress,
              validator:  (value){
                if(value.isEmpty || !value.contains('@')){
                  return 'Invalid Email';
                }
              },
              onSaved: (value){
                userInfo['email']=value;
              },
            ),
            TextFormField(
              decoration:const InputDecoration(labelText:'Password'),
              obscureText: true,
              validator: (value){
                if(value.isEmpty || value.length<5){
                  return 'Invalid Email';
                }
              },
              onSaved: (value){
                userInfo['password']=value;
              },
            ),
            SizedBox(height:20),
            isLoading? 
            Center(child: CircularProgressIndicator()):
            RaisedButton(
              color: Colors.green,
              child: const Text('Log In',),
              onPressed: sumbmit)
          ]
        )
        ),
    );
  }
}