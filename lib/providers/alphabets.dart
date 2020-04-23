import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import './alpha_details.dart';
import 'dart:convert';

class Alphabets extends ChangeNotifier{
  List<AlphabetDetails> items=[];

  final String token;

  Alphabets(this.token,this.items);

  List<AlphabetDetails> searchByAlpha(String alphabet){
    var loadedProducts=[];
    loadedProducts=items.where((alp)=>
      alp.alpha==alphabet
    ).toList();
    return [...loadedProducts];
  }

  AlphabetDetails searchByWord(String word){
    for(int i=0;i<items.length;i++){
      if(items[i].word==word){
        return items[i];
      }
    }
    return null;
  }
  
  Future<void> retreive()async{
    final url='https://mproject-2f338.firebaseio.com/alphabets.json?auth=$token';
    try{
      final response=await http.get(url);
      final extractAlpabets= json.decode(response.body) as Map<String,dynamic>;
      final List<AlphabetDetails> loadedAlpha=[];
      extractAlpabets.forEach((alphaId,alphaData){
        loadedAlpha.add(AlphabetDetails(
          id:alphaId,
          alpha:alphaData['alpha'],
          word: alphaData['word'],
          emean: alphaData['emean'],
          mmean: alphaData['mmean'],
          sentence: alphaData['sentence']
        ));
      });
    items=loadedAlpha;
    notifyListeners();
    }catch(error){
      throw error;
    }
  }
}