import 'package:flutter/material.dart';
import './screens/auth_screen.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './screens/splash_screen.dart';
import './providers/users.dart';
import './providers/alphabets.dart';
import './providers/questions.dart';
import './screens/test_screen.dart';
import './screens/all_words_screen.dart';
import './screens/alphabets_screen.dart';
import './screens/result_screen.dart';
import './screens/word_screen.dart';
import './screens/word_detail_screen.dart';
import './screens/test_rules_screen.dart';
import './screens/previous_result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth()
          ),
          ChangeNotifierProxyProvider<Auth,Users>(
            update: (ctx,auth,previousUsers)=>Users(
              auth.token,
              auth.userId,
              auth.uname,
              previousUsers==null ?
              []:previousUsers.users
            ),
          ),
          ChangeNotifierProxyProvider<Auth,Alphabets>(
            update: (ctx,auth,previousAlphabets)=>Alphabets(
              auth.token,
              previousAlphabets==null ?
              []:previousAlphabets.items
            ),
          ),
          ChangeNotifierProxyProvider<Auth,Questions>(
            update: (ctx,auth,previousQuestions)=>Questions(
              auth.token,
              previousQuestions==null?
              []:previousQuestions.test
            ),
          )
      ],
      child: Consumer<Auth>(
        builder:(ctx,auth,_)=>
         MaterialApp(
           debugShowCheckedModeBanner: false,
          title: 'VocEnhancer',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.green
          ),
          home:auth.token!=null?
          AlphabetsScreen():FutureBuilder(
            future: auth.tryAutoLogin(),
            builder:(ctx,authResultSnapshot)=>
            authResultSnapshot.connectionState==ConnectionState.waiting ?
            SplashScreen():
          AuthScreen()
        ),
        routes: {
          PreviousResultScreen.routName:(ctx)=>PreviousResultScreen(),
          TestRulesScreen.routName:(ctx)=>TestRulesScreen(),
          TestScreen.routName:(ctx)=>TestScreen(),
          ResultScreen.routName:(ctx)=>ResultScreen(),
          AlphabetsScreen.routName:(ctx)=>AlphabetsScreen(),
          WordScreen.routName:(ctx)=>WordScreen(),
          WordDetailScreen.routName:(ctx)=>WordDetailScreen(),
          AllWordsScreen.routName:(ctx)=>AllWordsScreen()
        },
      ),
      )
    );
  }
}

