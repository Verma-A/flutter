import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final searchKey = TextEditingController();
  Map data;
  List<String> datax;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New flutter',
      home: new Scaffold(
          appBar: AppBar(
            title: new Text('Image Search'),
          ),
          body: FutureBuilder(
            future: _printText(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                print("snap data is nul====");
                if (snap.error != null) {
                  print("===error===: " + snap.error.toString());
                }
                return Container(
                  alignment: Alignment.center,
                  child: Text('Loading....'),
                );
              } else {
                print("snap data have some data====");

                new ListView.builder(
                  itemCount: snap.data == null ? 0 : snap.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                        child: new Image(
                      image: new AssetImage(snap.data[index]),
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ));
                  },
                );
              }
            },
          ),
          // Column(
          //           children: <Widget>[
          //             new TextField(
          //               controller: searchKey,
          //               decoration: new InputDecoration(
          //                   labelStyle: new TextStyle(inherit: true),
          //                   labelText: 'Search',
          //                   icon: new Icon(Icons.search),
          //                   border: new OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(30.0))),
          //               onEditingComplete: _printText,
          //             ),
          //             Expanded(
          //                 child: FutureBuilder(
          //               future: _printText(),
          //               builder: (BuildContext context, AsyncSnapshot snap) {
          //                 if (snap.data==null){

          //                   print("snap data is nul====");
          //                   if (snap.error!=null){
          //                     print("===error===: "+snap.error.toString());
          //                   }
          //                   return Container(
          //                     alignment: Alignment.center,
          //                     child: Text('Loading....'),
          //                   );
          //                 }else{
          //                   print("snap data have some data====");

          //                 new ListView.builder(
          //                   itemCount: snap.data == null ? 0 : snap.data.length,
          //                   itemBuilder: (BuildContext context, int index) {
          //                     return new Card(
          //                         child: new Image(
          //                       image: new AssetImage(snap.data[index]),
          //                       fit: BoxFit.contain,
          //                       alignment: Alignment.center,
          //                     ));
          //                   },
          //                 );
          //                 }
          //               },
          //             ))
          //           ],
          //         ),
          // chlid:new ButtonBar()
          floatingActionButton: new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              setState:
              () {
                _printText();
              };
            },
            splashColor: Colors.blueGrey,
            color: Colors.blue,
            highlightColor: Colors.blue,
            alignment: Alignment.center,
            // alignment: Alignment.topRight,
          )
          // new ButtonTheme(
          //   textTheme: ButtonTextTheme.normal
          //   // layoutBehavior: ButtonBarLayoutBehavior.padded,
          // )
          ),
    );
  }

  Future<List<String>> _printText() async {
    String url;
    url =
        "https://www.googleapis.com/customsearch/v1?key=AIzaSyBPlbg3ncXsxjAnVGlA83Vo3hzuTzGA-Fs&cx=015364390810903764394:nvjacwgxlms&imgSize=medium&searchType=image&q=" +
            searchKey.text;
    var res = await http.get(url);
    data = jsonDecode(res.body);
    String temp;
    List<String> d = [];
    print("=========Value of rd=======: " + d.toString());
    if (data == null) {
      print("=====data is null");
    }
    for (var x in data["items"]) {
      temp = x["link"];
      d.add(temp);
    }
    return d;
  }
}
