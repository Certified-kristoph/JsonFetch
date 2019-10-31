import 'dart:convert';
//to convert Data from the data base

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listgenerate/classes/note.dart';
//This is the class used for the Fetch process

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Fetch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fetch list app'),
    );
  }
}
//Initialize a Stateful Widget
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _notes = List<Note>();
  //This is for Initialization

  Future<List<Note>> fetchNotes() async {
    var url =
        'https://raw.githubusercontent.com/boriszv/json/master/random_example.json';
    var response = await http.get(url);

    var notes = List<Note>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
    }
  }
  //returns the class Notes
   return notes;
  }

  @override
  //State Implementation for the Note Sync
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }


  @override
  //Body assumed by fetched Data
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32, bottom: 16, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _notes[index].title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _notes[index].text,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount:_notes.length,
          //Generates as much data as possible from the API
        ));
  }
}
