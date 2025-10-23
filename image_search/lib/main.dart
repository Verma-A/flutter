import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImgSrch(title: 'Final image search'),
    );
  }
}

class ImgSrch extends StatefulWidget {
  final String title;
  const ImgSrch({super.key, required this.title});

  @override
  _ImgSrchState createState() => _ImgSrchState();
}

class _ImgSrchState extends State<ImgSrch> {
  final searchKey = TextEditingController();
  
  Future<List<String>> _printText() async {
    // String url;
    // url =
    //     "http://aman:7000/getdata";
    // var res = await http.get(url);
    // Map data = jsonDecode(res.body);
    // String temp;
    // List<String> d = [];
    // if (data == null) {
    //   print("=====data is null");
    // }
    // if (data["items"]!=null){
    // for (var x in data["items"]) {
    //   temp = x["link"];
    //   d.add(temp);
    // }
    // }
    // print("=========Value of rd=======: " + d.toString());
    List<String> d=[];
    d.add('https://cdn.cliqueinc.com/cache/posts/253245/most-beautiful-flowers-253245-1522430224147-main.500x0c.jpg?interlace=true&quality=70');
    d.add('https://floristxpress.com/blog/wp-content/uploads/2016/09/dahlias-wallpaper-5-1-1024x681.jpg');
    d.add('https://floristxpress.com/blog/wp-content/uploads/2016/09/bird_of_paradise_2-300x226.jpg');
    d.add('https://floristxpress.com/blog/wp-content/uploads/2016/09/calla-lily-flower-season-300x199.jpg');
    d.add('https://floristxpress.com/blog/wp-content/uploads/2016/09/Water-Lily-flowers-33698264-1024-768-300x225.jpg');

  print("Value of d=: ${d.toString()}");
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageSearch'),
      ),
      body: FutureBuilder(
            future: _printText(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                if (snap.error != null) {
                  print("error======> ${snap.error.toString()}");
                }
                return const Center(
                  child: Text('Loading....'),
                );
              } else {
                return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Image.network(
                        snap.data[index],
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    );
                  },
                );
              }
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _printText, 
        child: const Icon(Icons.search),
      ),
      // Column(
      //   children: <Widget>[
      //     new TextField(
      //       controller: searchKey,
      //       decoration: new InputDecoration(
      //           labelStyle: new TextStyle(inherit: true),
      //           labelText: 'Search',
      //           icon: new Icon(Icons.search),
      //           border: new OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(30.0))),
      //       onEditingComplete: _printText,
      //     ),
      //     FutureBuilder(
      //       future: _printText(),
      //       builder: (BuildContext context, AsyncSnapshot snap) {
      //         if (snap.data == null) {
      //           if (snap.error != null) {
      //             print("error======> " + snap.error);
      //           }
      //           return Container(
      //             alignment: Alignment.center,
      //             child: Text('Loading....'),
      //           );
      //         } else {
      //           new ListView.builder(
      //             itemCount: snap.data.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               return new Card(
      //                 child: new Image(
      //                   image: new AssetImage(snap.data[index]),
      //                   fit: BoxFit.contain,
      //                   alignment: Alignment.center,
      //                 ),
      //               );
      //             },
      //           );
      //         }
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
