import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget{
  final Size deviceSize;
  SignUp(this.deviceSize);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> form=GlobalKey();
  var isLoading=false;
  final passwordController=TextEditingController();

  void showErrorDialog(String message){
    showDialog(
      context: context,
      builder: (ctx)=>
      AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed:()=> Navigator.of(context).pop(),
            child: Text('OK'))
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
      await Provider.of<Auth>(context,listen: false).signUp(
      userInfo['email'],userInfo['password'],userInfo['name']
    );
    }catch(error){
      showErrorDialog('Couldnt sign you up');
    }
    setState(() {
      isLoading=false;
    });
  }

  Map<String,String> userInfo={
    'name':'',
    'email':'',
    'password':''};

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      height: 280,
      margin: const EdgeInsets.symmetric(
        horizontal:50
      ),
      padding:const EdgeInsets.symmetric(
        horizontal:10,
        vertical:20
      ),
      child:Form(
        key: form,
        child: ListView(
          children:[
            TextFormField(
              decoration:InputDecoration(labelText:'Name'),
              keyboardType: TextInputType.text,
              validator:  (value){
                if(value.isEmpty ){
                  return 'This feild cannot be empty';
                }
              },
              onSaved: (value){
                userInfo['name']=value;
              },
            ),
            TextFormField(
              decoration:InputDecoration(labelText:'Email'),
              keyboardType: TextInputType.emailAddress,
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
              decoration:InputDecoration(labelText:'Password'),
              controller: passwordController,
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
              child: const Text('SignUp',),
              onPressed: sumbmit)
          ]
        )
        )
    );
  }
}