import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New flutter',
      home: const ImageSearchPage(),
    );
  }
}

class ImageSearchPage extends StatefulWidget {
  const ImageSearchPage({super.key});

  @override
  State<ImageSearchPage> createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  final searchKey = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search'),
      ),
      body: FutureBuilder(
        future: _printText(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.data == null) {
            if (snap.error != null) {
              print("===error===: ${snap.error.toString()}");
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
        onPressed: () {
          setState(() {
            _printText();
          });
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<List<String>> _printText() async {
    // Mock data - replace with actual API call when needed
    List<String> d = [];
    d.add('https://picsum.photos/400/300?random=1');
    d.add('https://picsum.photos/400/300?random=2');
    d.add('https://picsum.photos/400/300?random=3');
    d.add('https://picsum.photos/400/300?random=4');
    d.add('https://picsum.photos/400/300?random=5');
    
    // Uncomment below when you have a valid API key:
    // String url = "https://www.googleapis.com/customsearch/v1?key=YOUR_API_KEY&cx=YOUR_CX&imgSize=medium&searchType=image&q=${searchKey.text}";
    // var res = await http.get(Uri.parse(url));
    // Map<String, dynamic> data = jsonDecode(res.body);
    // List<String> d = [];
    // if (data["items"] != null) {
    //   for (var x in data["items"]) {
    //     d.add(x["link"]);
    //   }
    // }
    
    return d;
  }
}
