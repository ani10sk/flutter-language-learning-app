import 'package:flutter/material.dart';
import '../screens/all_words_screen.dart';
import '../screens/alphabets_screen.dart';
import '../screens/test_rules_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget{
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var isLoading=false;
  static var isinit=true;
  @override
  void didChangeDependencies() {
    if(isinit){
      setState(() {
        isLoading=true;
      });
       Provider.of<Users>(context,listen:false).fetchAndSet().then((_){
         setState(() {
           isLoading=false;
         });
      });
      
    }
    isinit=false;
     
      super.didChangeDependencies();
      }


  Future<void> launchUrl()async{
    const url='https://www.dictionary.com';
    if (await canLaunch(url)) {
    await launch(url,forceWebView: true);
  } else {
    throw 'Dictionary not available now';
  }
  }
  @override
  Widget build(BuildContext context){
    Future<void> logOut()async{
      await Provider.of<Auth>(context).logout();
    }
    return isLoading?
    Center(child:CircularProgressIndicator()):
    Drawer(
      child: Column(
        children:[
          AppBar(
            title:const Text('Settings',
            style:TextStyle(
              fontSize:14,fontWeight:FontWeight.bold
            ),
            ),
            actions: <Widget>[IconButton(icon: Icon(Icons.settings),onPressed:()=> Provider.of<Auth>(context).logout(),)],
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading:const Icon(Icons.select_all),
            title: const Text('Select All Words',style: TextStyle(fontWeight:FontWeight.bold),),
            onTap: ()=>Navigator.of(context).pushReplacementNamed(AllWordsScreen.routName),
          ),
          Divider(),
          ListTile(
            leading:const Icon(Icons.category),
            title: const Text('Categorize to alphabets',style: TextStyle(fontWeight:FontWeight.bold),),
            onTap: ()=>Navigator.of(context).pushReplacementNamed(AlphabetsScreen.routName),
          ),
          Divider(),
          ListTile(
            leading:const Icon(Icons.assignment),
            title: const Text('Weekly Test',style: TextStyle(fontWeight:FontWeight.bold),),
            onTap: ()=>Navigator.of(context).pushNamed(TestRulesScreen.routName),
          ),
          Divider(),
          ListTile(
            leading:const Icon(Icons.assignment),
            title: const Text('Dictionary',style: TextStyle(fontWeight:FontWeight.bold),),
            onTap: launchUrl,
          ),
          Divider(),
           ListTile(
            leading:const Icon(Icons.exit_to_app),
            title: const Text('Log Out',style: TextStyle(fontWeight:FontWeight.bold),),
            onTap: logOut,
          ),
        ]
      ),
    );
  }
}