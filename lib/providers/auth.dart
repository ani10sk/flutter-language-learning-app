import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  String uname=null;
  String token;
  String userId;
  DateTime expiryDate;
  Timer authTimer;

  bool isAuth(){
    return token!=null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDxl80yO4L2PwNIyzqFZjNqnvhIuf_7UYE';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error'];
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
       final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': token,
          'userId': userId,
          'expiryDate': expiryDate.toIso8601String(),
        },
      );
      try{
        if(uname!=null){
          await http.post('https://mproject-2f338.firebaseio.com/users/$userId.json?auth=$token',body:json.encode({
          'tdate':DateTime.now().toIso8601String(),
          'userId':userId,
          'nuser':'1',
          'testStatus':'1',
          'name':uname,
          'marks':'0'
        }));
        }
         
      }catch(error){
        throw error;
      }
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }
  
  Future<void> logIn(String emailId,String password)async{
  return _authenticate(emailId,password,'signInWithPassword');
  }

  Future<void> signUp(String emailId,String password,String name)async{
    uname=name;
    return _authenticate(emailId, password, 'signUp');

  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final sexpiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (sexpiryDate.isBefore(DateTime.now())) {
      return false;
    }
    token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    expiryDate = sexpiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    token = null;
    userId = null;
    expiryDate = null;
    if (authTimer != null) {
      authTimer.cancel();
      authTimer = null;
    }
    notifyListeners();
    print('hello');
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void autoLogout() {
    if (authTimer != null) {
      authTimer.cancel();
    }
    final timeToExpiry = expiryDate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}

