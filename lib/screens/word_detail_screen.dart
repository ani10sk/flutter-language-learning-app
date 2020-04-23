import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alphabets.dart';

class WordDetailScreen extends StatefulWidget{
  static const routName='/wordDetailScreen';

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  var emexpanded=false;
  var mmexpanded=false;
  var sexpanded=false;
  Widget expand(String content){
      return Column(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding:const EdgeInsets.all(10),
                    margin:const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical:0
                    ),
                    height:150,
                    width: double.infinity,
                    child:SingleChildScrollView(
                      child:Text(content,style: TextStyle(
                        fontSize:23,fontWeight:FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,)
                    )
                  ),SizedBox(height:40)
        ],
      );
  }
  Widget setHeader(String content,Function state,bool cstate){
    return Card(
              margin:const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 0
              ),
               child:Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  color: Colors.red[300],
                  alignment: Alignment.center,
                  width: double.infinity,
                  height:60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(content,style: TextStyle(
                          fontSize:20,fontWeight:FontWeight.bold),
                          textAlign: TextAlign.center,
                          ),IconButton(
                            icon: Icon((cstate) ?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down),
                             onPressed: state)]
                    ),
                    ),
                  elevation: 4, 
                );
  }
    void emstate(){
      setState(() {
        emexpanded=!emexpanded;
      });
    }
    void mmstate(){
      setState(() {
        mmexpanded=!mmexpanded;
      });
    }
    void sstate(){
      setState(() {
        sexpanded=!sexpanded;
      });
    }
  @override
  Widget build(BuildContext context){
    final alpha=ModalRoute.of(context).settings.arguments as String;
    final word=Provider.of<Alphabets>(context,listen: false).searchByWord(alpha);
    return Scaffold(
      appBar: AppBar(
        title:Text(word.word)
      ),
      body:SingleChildScrollView(
        child:Column(
          children:[
            SizedBox(
              height:10
            ),
            setHeader('MEANING',emstate,emexpanded),
            emexpanded ?expand(word.emean) :
            SizedBox(
              height:40
            ),
            setHeader('MALAYALAM MEANING',mmstate,mmexpanded),
           
            (mmexpanded) ?expand(word.mmean)
            :SizedBox(
              height: 40,
            ),
           setHeader('SAMPLE SENTENCE',sstate,sexpanded),
              (sexpanded) ?expand(word.sentence):SizedBox(height:40)
              ]
        )
    )
    );

  }
}