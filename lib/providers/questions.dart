import 'package:flutter/material.dart';
import './question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Questions extends ChangeNotifier{
  List<Question> test=[];

  final String token;

  Questions(this.token,this.test);

  Future<void> insertData()async{
    const url='https://mproject-2f338.firebaseio.com/test.json';
    try{
      await http.post(url,body:json.encode({
      'question':'',
      'answer':'',
      'option1':'',
      'option2':'',
    }));
    }catch(error){
      throw error;
    }
  }

    Future<void> fetchTest()async{
      final url='https://mproject-2f338.firebaseio.com/test.json?auth=$token';
      try{
        final response=await http.get(url);
        final extract=json.decode(response.body) as Map<String,dynamic>;
        final List<Question> loadedQ=[];
        extract.forEach((qid,qData){
          loadedQ.add(Question(
            question:qData['question'],
            answer: qData['answer'],
            option1: qData['option1'],
            option2: qData['option2']

          ));
        });
        test=loadedQ;
        notifyListeners();
      }catch(error){
        throw error;
      }
    }
    
  

}