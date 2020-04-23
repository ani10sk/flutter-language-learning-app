import 'package:flutter/material.dart';
import './user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users extends ChangeNotifier{
  List<User> users=[];

  final String token;
  final String userId;
  final String name;
  User cuser;



  Users(this.token,this.userId,this.name,this.users);

  

  Future<void> fetchAndSet()async{
    final url='https://mproject-2f338.firebaseio.com/users/$userId.json?auth=$token';
    try{
      final response=await http.get(url);
      final extractedData=json.decode(response.body) as Map<String,dynamic>;
      final List<User> loadedUsers=[];
      extractedData.forEach((userid,userdata){
        loadedUsers.add(User(
          tdate: userdata['tdate'],
          nuser:userdata['nuser'],
          userId: userdata['userId'],
          testStatus: userdata['testStatus'],
          name: userdata['name'],
          marks: userdata['marks']
        ));
      }); 
      cuser=loadedUsers.firstWhere((data)=>userId==data.userId);
      print(cuser.name);
      notifyListeners();
    }catch(error){
      throw error;
    }
    
  }

  Future<void> updateUser(User user)async{
    final url='https://mproject-2f338.firebaseio.com/users/$userId.json?auth=$token';
    try{
      await http.delete(url);
      await http.post(url,body: json.encode({
        'tdate':user.tdate,
          'userId':user.userId,
          'nuser':user.nuser,
          'testStatus':user.testStatus,
          'name':user.name,
          'marks':user.marks
      }));
    }catch(error){
      throw error;
    }
  }
  
}